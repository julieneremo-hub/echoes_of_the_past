import 'package:flutter/material.dart';

class TermsOfServicePopup extends StatelessWidget {
  const TermsOfServicePopup({super.key});

  // Helper method to trigger the popup overlay
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha:0.7), // Darkened overlay
      builder: (context) => const TermsOfServicePopup(),
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
                      'Terms of Service',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Serif',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Last updated: June 2026',
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
                      _buildSectionTitle('1. Acceptance of Terms'),
                      _buildSectionBody(
                        'By accessing and playing "Echoes of the Past," you agree to be bound by these Terms of Service and all applicable educational use guidelines. If you do not agree to these terms, please do not use the website or platform components.',
                      ),
                      _buildSectionTitle('2. Educational Use & Content License'),
                      _buildSectionBody(
                        'This game is developed exclusively as an educational framework focused on the cultural heritage and history of Cavite City. All historical narratives, multimedia fragments, and structural interactive layouts are protected by copyright laws.',
                      ),
                      _buildSectionTitle('3. Modifications to Service'),
                      _buildSectionBody(
                        'We reserve the right to deploy updates to gameplay patches, historical acts, or layout elements without prior structural notifications to improve learning integrations.',
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