import 'package:flutter/material.dart';

class PrivacyPolicyPopup extends StatelessWidget {
  const PrivacyPolicyPopup({super.key});

  // Helper method to trigger the popup overlay
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha:0.7), // Darkened overlay
      builder: (context) => const PrivacyPolicyPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF121824); // Deep dark blue/gray
    const Color accentColor = Color(0xFFF97316);     // Game orange
    const Color textColor = Colors.white;
    const Color subtitleColor = Colors.grey;

    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: Colors.white.withValues(alpha:0.1), width: 1),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 650),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Title & Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Serif',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Last updated: July 2026',
                      style: TextStyle(color: subtitleColor, fontSize: 12),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: subtitleColor),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Scrollable Content Box
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white.withValues(alpha:0.05)),
                ),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    padding: const EdgeInsets.only(right: 12.0),
                    children: [
                      _buildSectionTitle('1. Information We Collect'),
                      _buildSectionBody(
                        'When you create an account or subscribe to news updates for "Echoes of the Past," we collect limited personal details such as your email address, account username, and localized gameplay progress flags.',
                      ),
                      _buildSectionTitle('2. How We Use Your Data'),
                      _buildSectionBody(
                        'Your data is exclusively used to save educational game milestones, deliver player support, and send important game updates or news if subscribed. We do not sell or monetize personal information.',
                      ),
                      _buildSectionTitle('3. Educational & Student Privacy'),
                      _buildSectionBody(
                        'Because our application targets students and educators learning Cavite City’s history, we minimize data footprint by default. No personal student records or classroom performance tracking are shared with third parties.',
                      ),
                      _buildSectionTitle('4. AR Location Features'),
                      _buildSectionBody(
                        'When utilizing AR Artifact Discovery, camera and GPS permissions are accessed strictly on-device to render historical overlays in Cavite City. No location coordinates or visual feeds are stored on our servers.',
                      ),
                      _buildSectionTitle('5. Data Protection & Security'),
                      _buildSectionBody(
                        'We employ industry-standard encryption protocols to protect account credentials and prevent unauthorized access to your account data.',
                      ),
                      _buildSectionTitle('6. Contact Regarding Privacy'),
                      _buildSectionBody(
                        'If you wish to request account deletion or have questions regarding data handling, please reach out via the Contact Us popup or support channels.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Close/Acknowledge Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  "I Understand",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 6.0),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFF97316), // Signature accent orange
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSectionBody(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 13,
        height: 1.6,
      ),
    );
  }
}
