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
                      _buildSectionTitle('1. Information We Do Not Collect'),
                      _buildSectionBody(
                        'Echoes of the Past is designed to respect your privacy. We do not require you to create an account, log in, or provide any personal information (such as your name, email address, or phone number) to play the game.',
                      ),
                      _buildSectionTitle('2. Game Progress and Local Data'),
                      _buildSectionBody(
                        'Any progress, scores, or settings saved during gameplay are stored locally on your device\'s browser storage. This data remains on your device and is not transmitted to or stored on our servers.',
                      ),
                      _buildSectionTitle('3. Hosting and Technical Data'),
                      _buildSectionBody(
                        'Our website is hosted on Vercel. Standard web request information (such as IP addresses and browser types) may be handled by Vercel automatically to deliver the website securely and efficiently. This technical data is not linked to any personal identity.',
                      ),
                      _buildSectionTitle('4. Third-Party Links'),
                      _buildSectionBody(
                        'Our website or game footer may contain links to external sites (such as our official social media pages). We are not responsible for the privacy practices of external websites.',
                      ),
                      _buildSectionTitle('5. Contact Us'),
                      _buildSectionBody(
                        'If you have any questions about this Privacy Policy or the game, you can reach us via our official contact channel.',
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
