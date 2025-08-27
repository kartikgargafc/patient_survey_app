import 'package:flutter/material.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class WebPage extends StatelessWidget {
  const WebPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: WebViewX(
        width: size.width,
        height: size.height,
        initialContent: '''
          <iframe 
            width="100%" 
            height="100%" 
            src="https://forms.office.com/Pages/ResponsePage.aspx?id=Kb5hrQI0_EmmNtkc8YaZMCNZkp6pg6VHsRrAoN4EvltUQktFVkwxSUtPWEdUTDBPM0g0QjFOWDlNQS4u&embed=true" 
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
