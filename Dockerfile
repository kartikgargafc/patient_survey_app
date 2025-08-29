# Use an official Flutter runtime as a parent image
FROM ghcr.io/cirruslabs/flutter:3.35.0-0.1.pre

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Run flutter config to disable analytics
RUN flutter config --no-analytics

# Run flutter doctor to check dependencies
RUN flutter doctor

# Run flutter build for the web
RUN flutter build web --release

# Install Node.js and npm
RUN apt-get update && \
    apt-get install -y nodejs npm

# Install http-server globally
RUN npm install -g http-server

# Install supervisord
RUN apt-get install -y supervisor

# Create the supervisord configuration file
RUN echo "[supervisord]\nnodaemon=true\n\n[program:http-server]\ncommand=http-server build/web -p 8075\nautorestart=true\nstartretries=3\nstdout_logfile=/dev/fd/1\nstderr_logfile=/dev/fd/2" > /etc/supervisor/conf.d/supervisord.conf

# Expose port 8080
EXPOSE 8075

# Use supervisord to run the npm server in the foreground
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
