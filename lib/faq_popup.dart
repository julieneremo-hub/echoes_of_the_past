import 'package:flutter/material.dart';

class FaqPopup extends StatelessWidget {
  const FaqPopup({super.key});

  // Helper method to trigger the popup
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha:0.7), // Darkened overlay
      builder: (context) => const FaqPopup(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Theme matching your login/signup modal
    const Color backgroundColor = Color(0xFF121824); // Deep dark blue/gray
    const Color accentColor = Color(0xFFE06D32);     // Game orange
    const Color textColor = Colors.white;
    const Color subtitleColor = Colors.grey;

    // Sample historical/game FAQ data
    final List<Map<String, String>> faqData = [
      {
        'q': 'What is Echoes of the Past?',
        'a': 'An immersive educational role-playing game that transports players through the rich history and cultural heritage of Cavite City using a mysterious time machine.'
      },
      {
        'q': 'Is the game free to play?',
        'a': 'Yes! The game is completely free and designed as an educational tool for students, educators, and history enthusiasts alike.'
      },
      {
        'q': 'How do I use the AR Artifact Discovery feature?',
        'a': 'When playing on a mobile device, you can use your camera to view acquired artifacts.'
      },
      {
        'q': 'Can educators use this in classrooms?',
        'a': 'Absolutely. The game aligns with historical timelines and educational frameworks to provide an engaging supplement to traditional lessons.'
      },
    ];

    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: Colors.white.withValues(alpha:0.1), width: 1),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 550, maxHeight: 600),
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
                      'Frequently Asked Questions',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Serif', // Use your game's heading font
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Got questions? We have answers.',
                      style: TextStyle(color: subtitleColor, fontSize: 14),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: subtitleColor),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // FAQ List Accordion
            Expanded(
              child: Theme(
                // Cleans up the default expansion tile borders/lines
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ListView.separated(
                  itemCount: faqData.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return Container(
  decoration: BoxDecoration(
    color: Colors.white.withValues(alpha:0.03),
    borderRadius: BorderRadius.circular(8),
    border: Border.all( // <-- Changed from BorderSide to Border.all
      color: Colors.white.withValues(alpha:0.05),
    ),
  ),
  child: ExpansionTile(
                        iconColor: accentColor,
                        collapsedIconColor: subtitleColor,
                        title: Text(
                          faqData[index]['q']!,
                          style: const TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              bottom: 16.0,
                            ),
                            child: Text(
                              faqData[index]['a']!,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}