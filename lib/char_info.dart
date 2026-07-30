import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'faq_popup.dart';
import 'contact_popup.dart';
import 'terms_of_service_popup.dart';
import 'privacy_popup.dart';
import 'sys_req_popup.dart';
import 'cookie_popup.dart';

class CharacterInfoPage extends StatelessWidget {
  const CharacterInfoPage({super.key});

  // Helper method to open the game URL in a new browser tab
  Future<void> _launchGameUrl() async {
    final Uri gameUrl = Uri.parse('https://your-game-url.com'); // Replace with your actual game URL
    if (!await launchUrl(gameUrl, webOnlyWindowName: '_blank')) {
      debugPrint('Could not launch $gameUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 950;
    final bool isNarrowScreen = screenWidth < 900;
    final bool isMobileFooter = screenWidth < 700;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      endDrawer: isMobile ? _buildDrawer(context) : null,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, isMobile, scaffoldKey),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // MAIN HERO TITLE
                Padding(
                  padding: EdgeInsets.only(top: isNarrowScreen ? 40.0 : 80.0, bottom: 20.0),
                  child: Text(
                    "Character Info",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isNarrowScreen ? 44 : 72,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Meet the hero who journeys through time to uncover the truth about Cavite City's forgotten history",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                ),
                SizedBox(height: isNarrowScreen ? 40 : 80),

                // THE STORY BEGINS
                _contentWrapper(
                  screenWidth: screenWidth,
                  sectionContent: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _storyHeader("The Story Begins"),
                      _storyText(
                          "A historian sets out to uncover the true history of Cavite City. Curiosity drives the search. The goal is clear. Reveal forgotten events that shaped the city and the nation."),
                      _storyText(
                          "The research leads through old archives, scattered documents, and neglected records. Many sources repeat the same known stories. Few reveal anything new."),
                      _storyText(
                          "During the search, the historian discovers an abandoned structure hidden within the city. The building looks ruined and forgotten. Inside waits a neglected library filled with dusty books, loose papers, and silent shelves untouched for decades."),
                      _storyText(
                          "The historian begins examining the books. Most contain familiar historical records already studied before. The discoveries bring little progress. Persistence keeps the historian searching deeper into the building."),
                      _storyText(
                          "Behind one shelf, something unusual appears. A concealed door hides within the bookcase."),
                      _storyText("The historian opens it.", color: const Color(0xFFFB923C)),
                      _storyText("A hidden chamber lies beyond."),
                      _storyText(
                          "At the center of the room stands a strange machine. Shelves line the walls. Each shelf holds glass containers carefully preserved, as if they store something valuable."),
                      _storyText(
                          "A manual rests on a nearby table. The historian reads it."),
                      _storyText(
                          "The manual explains the machine. Each container stores fragments of history. These fragments hold recorded memories connected to important events in Cavite. The machine allows a person to experience those moments directly."),
                      _storyText("Curiosity grows stronger."),
                      _storyText(
                          "The historian selects one container and places it into the machine. A helmet and goggles connect to the device. The historian follows the instructions and activates it."),
                      _storyText("The world fades to black.", color: const Color(0xFFFB923C)),
                      _storyText("When vision returns, the library is gone."),
                      _storyText("The historian now stands in the past."),
                      _storyText(
                          "Cavite City appears alive. Ships arrive from distant lands. Traders negotiate along the docks. Workers repair vessels that crossed vast seas."),
                      _storyText("The truth becomes clear.", color: const Color(0xFFFB923C)),
                      _storyText(
                          "The machine does not show history. It sends the user into it.", color: const Color(0xFFFB923C)),
                      _storyText(
                          "The historian must now move through the defining moments of Cavite City. Each container reveals another period. The rise of the port. The defense of the harbor. The events that shaped the city's identity."),
                      _storyText("Each journey reveals another piece of the past."),
                      _storyText(
                          "The search for the true story of Cavite City has begun.", color: const Color(0xFFFB923C)),
                    ],
                  ),
                ),

                // CHARACTER CARDS & DESCRIPTION SECTION
                _contentWrapper(
                  screenWidth: screenWidth,
                  sectionContent: Column(
                    children: [
                      Wrap(
                        spacing: 30,
                        runSpacing: 30,
                        alignment: WrapAlignment.center,
                        children: [
                          _characterPortraitCard(
                            screenWidth: screenWidth,
                            name: "Leandro Vergara",
                            role: "Modern Historian",
                            gender: "Male",
                            time: "Present (2025)",
                            imageUrl: "assets/MC_Present.jpg",
                            accentColor: const Color(0xFF3B82F6),
                          ),
                          _characterPortraitCard(
                            screenWidth: screenWidth,
                            name: "Leandro Vergara",
                            role: "Time Traveler",
                            gender: "Male",
                            time: "Past (1896)",
                            imageUrl: "assets/MC_Past.jpg", // Asset for past version
                            accentColor: const Color(0xFFFB923C),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // DEDICATED DESCRIPTION AREA WITH BLUE & ORANGE GRADIENT
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 1000),
                        padding: EdgeInsets.all(isNarrowScreen ? 24.0 : 40.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white24, width: 1.5),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF1E3A8A), // Deep Blue
                              Color(0xFF0F172A), // Dark Slate
                              Color(0xFF7C2D12), // Deep Orange
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                              blurRadius: 20,
                              spreadRadius: -5,
                              offset: const Offset(-10, 0),
                            ),
                            BoxShadow(
                              color: const Color(0xFFFB923C).withValues(alpha: 0.15),
                              blurRadius: 20,
                              spreadRadius: -5,
                              offset: const Offset(10, 0),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.person_pin, color: Color(0xFFFB923C), size: 28),
                                SizedBox(width: 12),
                                Text(
                                  "About Leandro Vergara",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "A dedicated modern-day historian whose relentless search for the truth about Cavite City's past leads him to discover a hidden library and a mysterious time machine. By immersing himself directly into the recorded memories of the past, Leandro bridges the gap between present-day research and historical events, navigating the struggles and pivotal moments that defined the city.",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 17,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // THE JOURNEY THROUGH TIME
                _contentWrapper(
                  screenWidth: screenWidth,
                  sectionContent: Column(
                    children: [
                      Text(
                        "The Journey Through Time",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: isNarrowScreen ? 32 : 48,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: isNarrowScreen ? 30 : 60),
                      if (isNarrowScreen)
                        Column(
                          children: [
                            _journeyCard(
                                "Framing Narrative (2025)",
                                "Leandro Vergara discovers a hidden library with a mysterious time machine. Memory containers hold recorded memories of Cavite City's significant historical events, ready to be experienced.",
                                const Color(0xFF1E293B),
                                const Color(0xFF3B82F6),
                                isFullWidth: true),
                            const SizedBox(height: 20),
                            _journeyCard(
                                "Historical Acts (1571-1935)",
                                "Experience six scripted narrative acts through the eyes of Leandro as he steps into history. Witness the Spanish naval port, Cavite Mutiny, Gomburza execution, Philippine Independence, and more.",
                                const Color(0xFF1C1917),
                                const Color(0xFFF59E0B),
                                isFullWidth: true),
                          ],
                        )
                      else
                        Row(
                          children: [
                            _journeyCard(
                              "Framing Narrative (2025)",
                              "Leandro Vergara discovers a hidden library with a mysterious time machine. Memory containers hold recorded memories of Cavite City's significant historical events, ready to be experienced.",
                              const Color(0xFF1E293B),
                              const Color(0xFF3B82F6),
                            ),
                            const SizedBox(width: 30),
                            _journeyCard(
                              "Historical Acts (1571-1935)",
                              "Experience six scripted narrative acts through the eyes of Leandro as he steps into history. Witness the Spanish naval port, Cavite Mutiny, Gomburza execution, Philippine Independence, and more.",
                              const Color(0xFF1C1917),
                              const Color(0xFFF59E0B),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                // FOOTER
                FooterSection(isMobile: isMobileFooter),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- APP BAR & DRAWER WIDGETS ---

  SliverAppBar _buildAppBar(BuildContext context, bool isMobile, GlobalKey<ScaffoldState> scaffoldKey) {
    return SliverAppBar(
      backgroundColor: Colors.black.withValues(alpha: 0.9),
      floating: true,
      pinned: true,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      actions: isMobile
          ? [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
              ),
              const SizedBox(width: 12),
            ]
          : null,
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/EOTP_Logo.png',
              height: 48,
              width: 48,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 48,
                  width: 48,
                  color: const Color(0xFFC2410C),
                  alignment: Alignment.center,
                  child: const Text("E", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Echoes of the Past", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              Text("History & Culture of Cavite City", style: TextStyle(fontSize: 10, color: Color(0xFFFB923C))),
            ],
          ),
          if (!isMobile) ...[
            const Spacer(),
            _navLink(context, "Home", "/"),
            _navLink(context, "About", "/about"),
            _navLink(context, "Map", "/map"),
            _navLink(context, "Character Info", "/char_info", isActive: true),
            const SizedBox(width: 20),
            _buildPlayGameButton(isMobile: false),
          ],
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0F172A),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        children: [
          _drawerNavLink(context, "Home", "/"),
          _drawerNavLink(context, "About", "/about"),
          _drawerNavLink(context, "Map", "/map"),
          _drawerNavLink(context, "Character Info", "/char_info", isActive: true),
          const SizedBox(height: 24),
          _buildPlayGameButton(isMobile: true),
        ],
      ),
    );
  }

  Widget _buildPlayGameButton({required bool isMobile}) {
    return ElevatedButton.icon(
      onPressed: _launchGameUrl,
      icon: const Icon(Icons.play_arrow_rounded, size: 18, color: Colors.white),
      label: const Text("Play Game", style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC2410C),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 20,
          vertical: isMobile ? 16 : 15,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _storyHeader(String title, {Color color = Colors.white}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0, top: 10),
      child: Row(
        children: [
          if (color == Colors.white)
            const Icon(Icons.book_outlined, color: Color(0xFFFB923C), size: 28),
          if (color == Colors.white) const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: color, fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _storyText(String text, {Color color = Colors.white70}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 18, height: 1.6),
      ),
    );
  }

  // PORTRAIT CHARACTER CARD (WITHOUT EMBEDDED DESCRIPTION)
  // PORTRAIT CHARACTER CARD (FULL-BODY AUTO-FIT)
Widget _characterPortraitCard({
  required double screenWidth,
  required String name,
  required String role,
  required String gender,
  required String time,
  required String imageUrl,
  required Color accentColor,
}) {
  double cardWidth = (screenWidth - 150) / 2;
  if (cardWidth > 420) cardWidth = 420;
  if (screenWidth < 900) cardWidth = double.infinity;

  return Container(
    width: cardWidth,
    decoration: BoxDecoration(
      color: const Color(0xFF0F172A),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: accentColor.withValues(alpha: 0.4), width: 1.5),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            // Uses AspectRatio (9:16 vertical ratio) to maintain room for the full portrait
            AspectRatio(
              aspectRatio: 9 / 16,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                color: const Color(0xFF0B1120), // Dark background matching card aesthetic
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.contain, // Fits entire image (head to toe) without cropping
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 100, color: Colors.white10);
                  },
                ),
              ),
            ),
            // Time Badge overlay
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: accentColor.withValues(alpha: 0.8)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.access_time, color: accentColor, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 6,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        gender == "Male" ? Icons.person : Icons.person_3,
                        color: Colors.white54,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(gender, style: const TextStyle(color: Colors.white54)),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on, color: Colors.white54, size: 18),
                      const SizedBox(width: 4),
                      Text(role, style: const TextStyle(color: Colors.white54)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _journeyCard(String title, String desc, Color bgColor, Color accentColor, {bool isFullWidth = false}) {
    final Widget cardContent = Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withValues(alpha: 0.5), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.access_time_filled, color: accentColor, size: 48),
          const SizedBox(height: 20),
          Text(title, textAlign: TextAlign.center, style: TextStyle(color: accentColor, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Text(desc, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.5)),
        ],
      ),
    );

    return isFullWidth ? cardContent : Expanded(child: cardContent);
  }

  Widget _contentWrapper({required double screenWidth, required Widget sectionContent}) {
    double horizontalPadding = screenWidth < 600 ? 20.0 : 60.0;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: sectionContent,
        ),
      ),
    );
  }

  Widget _navLink(BuildContext context, String text, String route, {bool isActive = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(route),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? const Color(0xFFF97316) : Colors.white70,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _drawerNavLink(BuildContext context, String text, String route, {bool isActive = false}) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          color: isActive ? const Color(0xFFF97316) : Colors.white70,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.of(context).pushNamed(route);
      },
    );
  }
}

// --- RESPONSIVE FOOTER SECTION ---

class FooterSection extends StatelessWidget {
  final bool isMobile;
  const FooterSection({super.key, required this.isMobile});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.fromLTRB(isMobile ? 24 : 60, 80, isMobile ? 24 : 60, 40),
      child: Column(
        children: [
          if (!isMobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _footerCol(context, "Echoes of the Past", items: {
                    "An immersive educational role-playing game about the history and cultural heritage of Cavite City through scripted narrative acts and historical investigation.": ""
                  }),
                ),
                Expanded(
                  child: _footerCol(
                    context,
                    "Game",
                    items: {
                      "Home": "/",
                      "About": "/about",
                      "Map": "/map",
                      "Character Info": "/char_info",
                    },
                  ),
                ),
                Expanded(
                  child: _footerCol(
                    context,
                    "Support",
                    items: {
                      "FAQ": "popup_faq",
                      "Contact Us": "popup_contact",
                      "System Requirements": "popup_sys_req",
                    },
                  ),
                ),
                Expanded(
                  child: _footerCol(
                    context,
                    "Legal",
                    items: {
                      "Terms of Service": "popup_terms",
                      "Privacy Policy": "popup_privacy",
                      "Cookie Policy": "popup_cookie",
                    },
                  ),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _footerCol(context, "Echoes of the Past", items: {
                  "An immersive educational role-playing game about the history and cultural heritage of Cavite City through scripted narrative acts.": ""
                }),
                const SizedBox(height: 32),
                _footerCol(
                  context,
                  "Game",
                  items: {
                    "Home": "/",
                    "About": "/about",
                    "Map": "/map",
                    "Character Info": "/char_info",
                  },
                ),
                const SizedBox(height: 32),
                _footerCol(
                  context,
                  "Support",
                  items: {
                    "FAQ": "popup_faq",
                    "Contact Us": "popup_contact",
                    "System Requirements": "popup_sys_req",
                  },
                ),
                const SizedBox(height: 32),
                _footerCol(
                  context,
                  "Legal",
                  items: {
                    "Terms of Service": "popup_terms",
                    "Privacy Policy": "popup_privacy",
                    "Cookie Policy": "popup_cookie",
                  },
                ),
              ],
            ),
          const SizedBox(height: 60),
          const Divider(color: Colors.white10),
          const SizedBox(height: 20),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "© 2025 Echoes of the Past. All rights reserved.",
                style: const TextStyle(color: Colors.white24, fontSize: 12),
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
              ),
              if (isMobile) const SizedBox(height: 12),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.facebook, color: Colors.white70, size: 20),
                tooltip: 'Visit Facebook Page',
                onPressed: () {
                  _launchURL('https://www.facebook.com/profile.php?id=61592289615390');
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _footerCol(BuildContext context, String title, {required Map<String, String> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        ...items.entries.map((entry) {
          final String label = entry.key;
          final String pathValue = entry.value;

          if (pathValue.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(label, style: const TextStyle(color: Colors.white38, fontSize: 14, height: 1.5)),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: InkWell(
              onTap: () {
                if (pathValue == "popup_faq") {
                  FaqPopup.show(context);
                } else if (pathValue == "popup_contact") {
                  ContactPopup.show(context);
                } else if (pathValue == "popup_terms") {
                  TermsOfServicePopup.show(context);
                } else if (pathValue == "popup_privacy") {
                  PrivacyPolicyPopup.show(context);
                } else if (pathValue == "popup_cookie") {
                  CookiePolicyPopup.show(context);
                } else if (pathValue == "popup_sys_req") {
                  SysReqPopup.show(context);
                } else {
                  Navigator.of(context).pushNamed(pathValue);
                }
              },
              child: Text(
                label,
                style: const TextStyle(color: Colors.white38, fontSize: 14),
              ),
            ),
          );
        }),
      ],
    );
  }
}