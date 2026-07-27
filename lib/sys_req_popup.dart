import 'package:flutter/material.dart';

class SysReqPopup extends StatelessWidget {
  const SysReqPopup({super.key});

  // Helper method to trigger the popup overlay
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha:0.7),
      builder: (context) => const SysReqPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF121824); // Deep dark blue/gray
    const Color accentColor = Color(0xFFF97316);     // Game orange
    const Color cardColor = Color(0xFF0F172A);       // Slightly darker card bg
    const Color textColor = Colors.white;
    const Color subtitleColor = Colors.grey;

    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: Colors.white.withValues(alpha:0.1), width: 1),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 620, maxHeight: 680),
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
                      'System Requirements',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Serif',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Check compatibility before playing or downloading',
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

            // Scrollable Content
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: ListView(
                  padding: const EdgeInsets.only(right: 8.0),
                  children: [
                    // --- DESKTOP / WEB SECTION ---
                    _buildPlatformHeader(
                      icon: Icons.computer,
                      title: 'Desktop / PC (Web Platform)',
                      badgeText: 'Play in Browser',
                      accentColor: accentColor,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        children: const [
                          _BuildSpecRow('Browser', 'Chrome 90+, Firefox 88+, Edge, Safari 14+'),
                          _BuildSpecRow('WebGL Support', 'WebGL 2.0 Enabled'),
                          _BuildSpecRow('Memory (RAM)', '4 GB RAM or higher'),
                          _BuildSpecRow('Network', 'Broadband Internet Connection'),
                          _BuildSpecRow('Controls', 'Mouse & Keyboard required'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // --- MOBILE SECTION ---
                    _buildPlatformHeader(
                      icon: Icons.phone_android,
                      title: 'Mobile Devices (Downloadable App)',
                      badgeText: 'Install App',
                      accentColor: accentColor,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        children: const [
                          _BuildSpecRow('Android OS', 'Android 8.0 (Oreo) or higher'),
                          _BuildSpecRow('iOS Version', 'iOS 13.0 or higher'),
                          _BuildSpecRow('Storage Space', 'approx. 250 MB free space'),
                          _BuildSpecRow('RAM', '3 GB Minimum (4 GB Recommended)'),
                          _BuildSpecRow('AR Features', 'ARCore / ARKit compatible camera'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Close Button
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
                  "Got It",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildPlatformHeader({
    required IconData icon,
    required String title,
    required String badgeText,
    required Color accentColor,
  }) {
    return Row(
      children: [
        Icon(icon, color: accentColor, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha:0.15),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: accentColor.withValues(alpha:0.4)),
          ),
          child: Text(
            badgeText,
            style: TextStyle(color: accentColor, fontSize: 11, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }
}

class _BuildSpecRow extends StatelessWidget {
  final String label;
  final String value;

  const _BuildSpecRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}