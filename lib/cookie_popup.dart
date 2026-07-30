import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CookiePolicyPopup extends StatelessWidget {
  const CookiePolicyPopup({super.key});

  /// Preference key for tracking consent
  static const String _consentKey = 'cookie_consent_given';

  /// Opens the full Cookie Policy dialog popup
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      builder: (context) => const CookiePolicyPopup(),
    );
  }

  /// Displays the bottom SnackBar banner upon entering the website ONLY ONCE
  static Future<void> showBanner(BuildContext context, {VoidCallback? onAccept}) async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasConsented = prefs.getBool(_consentKey) ?? false;

    // If user already consented, do not show the banner again
    if (hasConsented) return;

    if (!context.mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 6,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          backgroundColor: const Color(0xFF0F172A), // Dark slate container
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
          ),
          duration: const Duration(days: 365), // Keep visible until user interacts
          content: LayoutBuilder(
            builder: (context, constraints) {
              final bool isMobile = constraints.maxWidth < 600;

              final Widget contentWidget = Row(
                children: [
                  const Icon(Icons.cookie_outlined, color: Color(0xFFF97316), size: 28),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "We use cookies",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                            children: [
                              const TextSpan(
                                text: "We use essential cookies to optimize performance and save your preferences. ",
                              ),
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () => show(context),
                                  child: const Text(
                                    "Learn more",
                                    style: TextStyle(
                                      color: Color(0xFFF97316),
                                      decoration: TextDecoration.underline,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );

              final List<Widget> actionButtons = [
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    show(context);
                  },
                  child: const Text(
                    "Preferences",
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    // Save preference so it never shows again
                    final instance = await SharedPreferences.getInstance();
                    await instance.setBool(_consentKey, true);
                    
                    if (onAccept != null) onAccept();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF97316),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: const Text(
                    "Accept All",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ];

              if (isMobile) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    contentWidget,
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: actionButtons,
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: contentWidget),
                  const SizedBox(width: 16),
                  Row(children: actionButtons),
                ],
              );
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF121824);
    const Color cardColor = Color(0xFF0F172A);
    const Color accentColor = Color(0xFFF97316);

    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 580, maxHeight: 620),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.cookie_outlined, color: accentColor, size: 28),
                    SizedBox(width: 12),
                    Text(
                      'Cookie Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white54),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Content List
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Echoes of the Past uses cookies to improve gameplay performance and store local preferences. Since no account registration is required to play, essential cookies help save your progress directly on your device.',
                      style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
                    ),
                    const SizedBox(height: 20),

                    _buildCookieOption(
                      cardColor: cardColor,
                      accentColor: accentColor,
                      title: "Essential Cookies",
                      badge: "Required",
                      description: "Required for saving game progress, audio preferences, and essential site navigation.",
                    ),
                    const SizedBox(height: 12),

                    _buildCookieOption(
                      cardColor: cardColor,
                      accentColor: accentColor,
                      title: "Analytics & Performance",
                      badge: "Optional",
                      description: "Helps us measure web performance and loading times to ensure optimal browser gameplay.",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      final instance = await SharedPreferences.getInstance();
                      await instance.setBool(_consentKey, true);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white24),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Save Preferences", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      final instance = await SharedPreferences.getInstance();
                      await instance.setBool(_consentKey, true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text("Accept All", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCookieOption({
    required Color cardColor,
    required Color accentColor,
    required String title,
    required String badge,
    required String description,
  }) {
    final bool isRequired = badge == "Required";
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isRequired ? accentColor.withValues(alpha: 0.2) : Colors.white10,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: isRequired ? accentColor : Colors.grey,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}