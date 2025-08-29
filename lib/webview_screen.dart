import 'package:flutter/material.dart';
import 'package:patient_survey_app/choose_language.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class WebPage extends StatelessWidget {
  final String url;
  const WebPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "Patient Survey Form",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20, // bigger for visibility
            fontWeight: FontWeight.w600, // semi-bold
            letterSpacing: 1.2, // slight spacing
            fontFamily: 'Roboto', // or any custom font you’ve added
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LanguageSelectionPage(),
                  ),
                );
                // TODO: Handle new form button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF42b3a9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Fill New Form",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: WebViewX(
        width: size.width,
        height: size.height,
        initialContent:
            '''
          <iframe 
            width="100%" 
            height="100%" 
            src=$url
            frameborder="0" 
            marginwidth="0" 
            marginheight="0" 
            style="border:none; width:100%; height:100vh;" 
            allowfullscreen 
            webkitallowfullscreen 
            mozallowfullscreen 
            msallowfullscreen>
          </iframe>
        ''',
        initialSourceType: SourceType.html,
      ),
    );
  }
}
