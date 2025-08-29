import 'package:flutter/material.dart';
import 'package:patient_survey_app/choose_language.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds then navigate to LanguageSelectionPage
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LanguageSelectionPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double size = constraints.maxWidth < constraints.maxHeight
                ? constraints.maxWidth * 0.6
                : constraints.maxHeight * 0.6;

            return Image.asset(
              'assets/png.png',
              width: size,
              height: size,
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }
}
