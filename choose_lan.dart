import 'package:flutter/material.dart';
import 'package:patient_survey_app/webview_screen.dart';
import 'package:animate_do/animate_do.dart';

class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  String? selectedLanguage; // store "en" or "ar"

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3CCFCF), Color(0xFFB2F3EA)],
            stops: [0.3, 1.0],
            begin: AlignmentDirectional(1.0, -1.0),
            end: AlignmentDirectional(-1.0, 1.0),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 30),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double size =
                            constraints.maxWidth < constraints.maxHeight
                            ? constraints.maxWidth * 0.25
                            : constraints.maxHeight * 0.25;

                        return ZoomIn(
                          child: Image.asset(
                            'assets/png.png',
                            width: size,
                            height: size,
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                  ),
                  // Title
                  FadeInDown(
                    child: Text(
                      selectedLanguage == null
                          ? "Choose Your Language"
                          : (selectedLanguage == "en"
                                ? "Select an Option"
                                : "اختر خيارًا"),
                      style: TextStyle(
                        fontSize: isMobile ? 22 : 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // If no language chosen yet → show language cards
                  if (selectedLanguage == null)
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: [
                        FadeInLeft(
                          delay: const Duration(milliseconds: 300),
                          child: _languageCard(
                            context: context,
                            title: "Hi 👋",
                            subtitle: "Fill form in English",
                            langLabel: "English",
                            alignment: CrossAxisAlignment.start,
                            onTap: () {
                              setState(() {
                                selectedLanguage = "en";
                              });
                            },
                          ),
                        ),
                        FadeInRight(
                          delay: const Duration(milliseconds: 500),
                          child: _languageCard(
                            context: context,
                            title: "👋 مرحبا",
                            subtitle: "املأ النموذج بالعربية",
                            langLabel: "العربية",
                            alignment: CrossAxisAlignment.end,
                            onTap: () {
                              setState(() {
                                selectedLanguage = "ar";
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  else
                    // Show 4 options after language chosen
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: [
                        FadeInUp(
                          delay: const Duration(milliseconds: 300),
                          child: _optionCard(
                            context: context,
                            label: selectedLanguage == "en"
                                ? "OPD"
                                : "عيادة خارجية",
                            url: _getUrl("opd"),
                          ),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          child: _optionCard(
                            context: context,
                            label: selectedLanguage == "en"
                                ? "Counselling"
                                : "استشارة",
                            url: _getUrl("counselling"),
                          ),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 500),
                          child: _optionCard(
                            context: context,
                            label: selectedLanguage == "en"
                                ? "OT"
                                : "غرفة العمليات",
                            url: _getUrl("ot"),
                          ),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 600),
                          child: _optionCard(
                            context: context,
                            label: selectedLanguage == "en"
                                ? "Pharmacy"
                                : "صيدلية",
                            url: _getUrl("pharmacy"),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Language card widget
  Widget _languageCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String langLabel,
    required CrossAxisAlignment alignment,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: isMobile ? screenWidth * 0.8 : 280,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
          border: Border.all(color: const Color(0xFF4CBFB2), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: alignment,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: isMobile ? 20 : 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: isMobile ? 15 : 17,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              langLabel,
              style: TextStyle(
                fontSize: isMobile ? 15 : 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Option card for OPD, Counselling, OT, Pharmacy
  Widget _optionCard({
    required BuildContext context,
    required String label,
    required String url,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WebPage(url: url)),
        );
      },
      child: Container(
        width: isMobile ? screenWidth * 0.8 : 220,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
          border: Border.all(color: const Color(0xFF4CBFB2), width: 1.5),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  /// Get form URL for each option
  String _getUrl(String option) {
    // NOTE: Replace these with your actual form links for each option
    switch (option) {
      case "opd":
        return "https://forms.office.com/Pages/ResponsePage.aspx?id=...&opd";
      case "counselling":
        return "https://forms.office.com/Pages/ResponsePage.aspx?id=...&counselling";
      case "ot":
        return "https://forms.office.com/Pages/ResponsePage.aspx?id=...&ot";
      case "pharmacy":
        return "https://forms.office.com/Pages/ResponsePage.aspx?id=...&pharmacy";
      default:
        return "https://forms.office.com/Pages/ResponsePage.aspx?id=...";
    }
  }
}
