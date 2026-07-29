import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'faq_popup.dart';
import 'contact_popup.dart';
import 'terms_of_service_popup.dart';
import 'privacy_popup.dart';
import 'sys_req_popup.dart';
import 'cookie_popup.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

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
                // HERO TITLE
                Padding(
                  padding: EdgeInsets.symmetric(vertical: isMobile ? 40.0 : 80.0),
                  child: Text(
                    "About Echoes of the Past",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 36 : 56,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),

                // THE STORY SECTION
                _buildSection(
                  isMobile: isMobile,
                  title: "The Story",
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Echoes of the Past is an immersive educational role-playing game that transports players through the history of Cavite City. A historian discovers a hidden library containing a mysterious time machine and memory container--glass vials holding recorded memories of significant historical events. By inserting a container into the machine, the player is transported into scripted historical acts, embodying characters who witness pivotal moments firsthand.",
                        style: TextStyle(color: Colors.white70, fontSize: 18, height: 1.6),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Cavite City, one of the oldest cities in the Philippines, served as a major Spanish naval port and the site of defining historical events including the Cavite Mutiny of 1872, the execution of the Gomburza priests, and the Declaration of Philippine Independence in 1898. The game preserves this rich heritage through six scripted narrative acts, each set in a distinct historical period.",
                        style: TextStyle(color: Colors.white70, fontSize: 18, height: 1.6),
                      ),
                    ],
                  ),
                ),

                // GAME MECHANICS SECTION
                _buildSection(
                  isMobile: isMobile,
                  title: "Game Mechanics",
                  child: Column(
                    children: [
                      Flex(
                        direction: isMobile ? Axis.vertical : Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _mechanicCard(
                            "Scripted Historical Acts",
                            "Experience six distinct historical periods through structured narrative acts. Each act is set in authentic Cavite City locations including Fort San Felipe, the Cavite Arsenal, and the harbors of Manila Bay.",
                            isMobile,
                          ),
                          SizedBox(width: isMobile ? 0 : 20, height: isMobile ? 20 : 0),
                          _mechanicCard(
                            "Character Roleplay",
                            "Embody historical characters Marcelino Fuentes or Dolores Lazcano as you interact with NPCs based on real figures like Emilio Aguinaldo, the Gomburza priests, and Julian Felipe.",
                            isMobile,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Flex(
                        direction: isMobile ? Axis.vertical : Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _mechanicCard(
                            "Historical Investigation",
                            "Gather information by observing NPCs, examining documents and objects, and collecting entries from a searchable database of 20-30 verified historical facts about Cavite City.",
                            isMobile,
                          ),
                          SizedBox(width: isMobile ? 0 : 20, height: isMobile ? 20 : 0),
                          _mechanicCard(
                            "AR Artifact Discovery",
                            "In the modern timeline, use your device's camera to discover historical artifacts overlaid on real-world locations in Cavite City through augmented reality.",
                            isMobile,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // EDUCATIONAL IMPACT SECTION
                _buildSection(
                  isMobile: isMobile,
                  title: "Educational Impact",
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "The game addresses the declining historical awareness among Filipino youth by transforming passive learning into active engagement. Studies show that 67% of youth aged 15-24 find traditional history education unengaging.",
                        style: TextStyle(color: Colors.white70, fontSize: 18, height: 1.6),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Echoes of the Past aligns with UN Sustainable Development Goal #4: Quality Education, providing an inclusive digital platform that promotes cultural literacy and ensures Cavite's history remains accessible to all.",
                        style: TextStyle(color: Colors.white70, fontSize: 18, height: 1.6),
                      ),
                    ],
                  ),
                ),

                // TARGET AUDIENCE SECTION
                _buildSection(
                  isMobile: isMobile,
                  title: "Target Audience",
                  child: Column(
                    children: [
                      _featureItem("Students (15-18)", "An engaging way to learn Philippine history that complements classroom instruction."),
                      _featureItem("Educators", "A powerful digital teaching tool for lesson plans and classroom activities."),
                      _featureItem("Tourists", "An immersive introduction to Cavite's historical significance through AR features."),
                      _featureItem("History Enthusiasts", "Deep dive into revolutionary events with authentic historical content."),
                    ],
                  ),
                ),

                // FOOTER SECTION
                FooterSection(isMobile: isMobile),
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
            _navLink(context, "About", "/about", isActive: true),
            _navLink(context, "Map", "/map"),
            _navLink(context, "Character Info", "/char_info"),
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
          _drawerNavLink(context, "About", "/about", isActive: true),
          _drawerNavLink(context, "Map", "/map"),
          _drawerNavLink(context, "Character Info", "/char_info"),
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

  // --- NAVIGATION HELPERS ---

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

  // --- CONTENT SECTION BUILDERS ---

  Widget _buildSection({
    required bool isMobile,
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24.0 : 60.0, vertical: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFF97316),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _mechanicCard(String title, String desc, bool isMobile) {
    final cardContent = Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Color(0xFFFB923C), fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(desc, style: const TextStyle(color: Colors.white60, fontSize: 15, height: 1.5)),
        ],
      ),
    );

    return isMobile ? SizedBox(width: double.infinity, child: cardContent) : Expanded(child: cardContent);
  }

  Widget _featureItem(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: Color(0xFFF97316), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 18, height: 1.5, fontFamily: 'Roboto'),
                children: [
                  TextSpan(text: "$title: ", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  TextSpan(text: desc, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
        ],
      ),
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