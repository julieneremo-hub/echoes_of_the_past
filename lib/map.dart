import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'faq_popup.dart';
import 'contact_popup.dart';
import 'terms_of_service_popup.dart';
import 'privacy_popup.dart';
import 'sys_req_popup.dart';

// --- DATA MODEL ---
class HistoricalLocation {
  final String name;
  final String era;
  final String description;
  final IconData icon;
  final List<String> features;
  final List<String> loot;
  final String note;
  
  // Percentage coordinates (0.0 to 1.0) for absolute scaling during resize
  final double topPercent;
  final double leftPercent;

  HistoricalLocation({
    required this.name,
    required this.era,
    required this.description,
    required this.icon,
    required this.features,
    required this.loot,
    required this.note,
    required this.topPercent,
    required this.leftPercent,
  });
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<HistoricalLocation> locations = [
    HistoricalLocation(
      name: "Santa Cruz",
      era: "Revolutionary Civilian Support",
      description: "Named by the Spanish after the Holy Cross, Santa Cruz was a bustling, growing district lined with busy markets and purposeful traders. Beneath its surface as a commercial hub where people lived and shared supplies, it operated as a vital civilian artery for the revolution. Instead of fighting with guns, the citizens here supported the cause covertly by passing messages and packages through the bustling crowds.",
      icon: Icons.people,
      features: ["Bustling Commercial Markets", "Covert Revolutionary Communications", "Civilian Supply Network"],
      loot: ["Scroll"],
      note: "Historical Note: Developed to absorb workers and merchants serving the naval base. Its dense urban layout provided ideal camouflage for the revolution's covert supply lines.",
      topPercent: 0.32, leftPercent: 0.36,
    ),
    HistoricalLocation(
      name: "Caridad",
      era: "Industrial & Revolutionary",
      description: "Originally its own distinct town before 1903, Caridad was characterized by its narrow streets and close-knit homes. The livelihood of its residents was heavily tied to the nearby arsenal through ship repair and manual labor. Named by priests after the word for charity, it was the birthplace of the Chavacano language—a mix of Spanish and local dialects. The removal of worker privileges, such as tax exemptions and freedom from forced labor in 1872, sparked the historic Cavite Mutiny.",
      icon: Icons.home, 
      features: ["Arsenal Labor Settlement", "Birthplace of the Chavacano Language", "Epicenter of the 1872 Cavite Mutiny"],
      loot: ["Bullet"],
      note: "Historical Note: Merged into modern Cavite City in 1940. The 1872 Mutiny here, and the subsequent harsh Spanish crackdowns, catalyzed the Philippine nationalist movement.",
      topPercent: 0.14, leftPercent: 0.16,
    ),
    HistoricalLocation(
      name: "Dalahican",
      era: "Late Colonial & American Transition",
      description: "Deriving its name from a local word meaning a path or a passage, Dalahican served as a vital coastal road and gateway connecting Cavite to other towns. Primarily a place for fishing, trade, and travel, its shores became a vantage point for the roaring cannons of the Battle of Manila Bay as Spanish ships burned. Years later, it transformed into a site of peaceful resolution, where Governor Ramon Samonte successfully convinced a group of rebels to surrender without violence, preserving the district's livelihood.",
      icon: Icons.route,
      features: ["Strategic Coastal Gateway", "Vantage Point for the Battle of Manila Bay", "Site of Peaceful Rebel Resolution"],
      loot: ["King’s Chess Piece"],
      note: "Historical Note: Named after dalahik (dragging boats across the isthmus). Highly strategic, it was heavily fortified by the Spanish to prevent land-based rebel attacks on the naval arsenal.",
      topPercent: 0.45, leftPercent: 0.58,
    ),
    HistoricalLocation(
      name: "San Roque",
      era: "Colonial & Reformist",
      description: "Established in 1614, this prominent public and commercial center was named after Saint Roch, the protector from disease, reflecting Spanish fears of sickness. Situated near the stone walls of Fort San Felipe, which guarded the port, San Roque's public square became a site of profound historical tragedy. It was here that the three martyr priests—Gómez, Burgos, and Zamora—were executed after being blamed for the mutiny, an event witnessed by a young José Rizal that forever shifted the nation's trajectory.",
      icon: Icons.hub,
      features: ["Public Square and Trade Hub", "Proximity to Fort San Felipe", "Martyrdom Site of Gomburza"],
      loot: ["Bible"],
      note: "Historical Note: Built outside the main Spanish walls specifically for Filipinos and Chinese immigrants. It briefly served as the capital of Emilio Aguinaldo’s revolutionary government in 1898.",
      topPercent: 0.58, leftPercent: 0.20,
    ),
    HistoricalLocation(
      name: "Kawit",
      era: "Philippine Revolution",
      description: "A pivotal municipality during the twilight of Spanish rule, Kawit became the grand stage for the Philippine Revolution. It was here that Emilio Aguinaldo stood before gathered crowds to declare that Spain no longer ruled the archipelago. The location marks the historic raising of the Philippine flag and the very first playing of the national anthem, composed by Julian Felipe, uniting the people in their pursuit of independence.",
      icon: Icons.flag,
      features: ["Declaration of Independence", "Inaugural Raising of the National Flag", "First Performance of the National Anthem"],
      loot: ["Sedula"],
      note: "Historical Note: Historically known as Cavite el Viejo. The June 12, 1898 Declaration of Independence was famously read from the window of the Aguinaldo Shrine here.",
      topPercent: 0.59, leftPercent: 0.82,
    ),
    HistoricalLocation(
      name: "Cavite La Punta",
      era: "Spanish Colonial & Galleon Trade",
      description: "Located at the northern edge of the peninsula, this area was chosen by the Spanish after 1571 due to its deep waters, which were perfect for galleons. It grew rapidly under Spanish engineers as a major port where laborers built ships and loaded valuable cargo like porcelain and silk. The area was frequented by Chinese craftsmen, leading to the naming of nearby Sangley Point, and featured a chapel dedicated to Saint Anthony where sailors prayed before long voyages.",
      icon: Icons.waves,
      features: ["Deep-Water Galleon Port", "Shipyard Operations & Cargo Loading"],
      loot: ["Pearl Necklace"],
      note: "Historical Note: Known as Cavite Puerto, it was the principal anchorage for the Manila-Acapulco Galleon Trade for over 250 years, making it a critical hub of global commerce.",
      topPercent: 0.09, leftPercent: 0.74,
    ),
  ];

  late HistoricalLocation selectedLocation;

  @override
  void initState() {
    super.initState();
    selectedLocation = locations[0]; 
  }

  // Helper method to open the game URL in a new browser tab
  Future<void> _launchGameUrl() async {
    final Uri gameUrl = Uri.parse('https://your-game-url.com'); // Replace with your actual game URL
    if (!await launchUrl(gameUrl, webOnlyWindowName: '_blank')) {
      debugPrint('Could not launch $gameUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 950;
    final bool isCompact = screenWidth < 1024;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF0F172A),
      endDrawer: isMobile ? _buildDrawer(context) : null,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, isMobile),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildHeroTitle(isCompact),
                
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isCompact ? 20 : 60, 
                    vertical: 20
                  ),
                  child: Flex(
                    direction: isCompact ? Axis.vertical : Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // INTERACTIVE MAP CONTAINER
                      Flexible(
                        flex: isCompact ? 0 : 1,
                        fit: isCompact ? FlexFit.loose : FlexFit.tight,
                        child: Container(
                          height: isCompact ? 400 : 550,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha:0.3),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Stack(
                                children: [
                                  Center(
                                    child: Opacity(
                                      opacity: 0.1, 
                                      child: Icon(Icons.map, size: isCompact ? 180 : 250, color: Colors.white)
                                    )
                                  ),
                                  
                                  ...locations.map((loc) {
                                    final double pinTop = loc.topPercent * constraints.maxHeight;
                                    final double pinLeft = loc.leftPercent * constraints.maxWidth;
                                    return Positioned(
                                      top: pinTop,
                                      left: pinLeft,
                                      child: _interactivePin(loc),
                                    );
                                  }),

                                  Positioned(bottom: 40, left: 20, child: _mapClick()),
                                  
                                  Positioned(
                                    bottom: 40, right: 40,
                                    child: _selectionLabel(selectedLocation.name, selectedLocation.era),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      
                      SizedBox(
                        width: isCompact ? 0 : 40, 
                        height: isCompact ? 30 : 0
                      ),

                      // DISTRICT DETAILS CONTENT SIDEBAR
                      Flexible(
                        flex: isCompact ? 0 : 1,
                        fit: isCompact ? FlexFit.loose : FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLocationHeader(),
                            const SizedBox(height: 16),
                            Text(
                              selectedLocation.description, 
                              style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.5)
                            ),
                            const SizedBox(height: 24),
                            const Text("| Key Features", style: TextStyle(color: Colors.orange, fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            ...selectedLocation.features.map((feature) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: _infoTile(feature),
                            )),
                            const SizedBox(height: 12),
                            _buildLootPanel(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                FooterSection(isMobile: isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- APP BAR & NAVIGATION COMPONENTS ---

  SliverAppBar _buildAppBar(BuildContext context, bool isMobile) {
    return SliverAppBar(
      backgroundColor: Colors.black.withValues(alpha:0.9),
      floating: true,
      pinned: true,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      actions: isMobile
          ? [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Echoes of the Past", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              Text("History & Culture of Cavite City", style: TextStyle(fontSize: 10, color: Color(0xFFFB923C))),
            ],
          ),
          if (!isMobile) ...[
            const Spacer(),
            _navLink(context, "Home", "/"),
            _navLink(context, "About", "/about"),
            _navLink(context, "Map", "/map", isActive: true),
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
          _drawerNavLink("Home", "/"),
          _drawerNavLink("About", "/about"),
          _drawerNavLink("Map", "/map", isActive: true),
          _drawerNavLink("Character Info", "/char_info"),
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

  Widget _drawerNavLink(String text, String route, {bool isActive = false}) {
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

  // --- MAP CORE INTERACTION WIDGETS ---

  Widget _interactivePin(HistoricalLocation loc) {
    bool isSelected = selectedLocation.name == loc.name;
    return GestureDetector(
      onTap: () => setState(() => selectedLocation = loc),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.orange.withValues(alpha:0.4),
          shape: BoxShape.circle,
          boxShadow: isSelected ? [BoxShadow(color: Colors.orange.withValues(alpha:0.5), blurRadius: 20, spreadRadius: 5)] : [],
        ),
        child: Icon(loc.icon, color: Colors.white, size: isSelected ? 28 : 20),
      ),
    );
  }

  Widget _buildLocationHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(12)),
          child: Icon(selectedLocation.icon, color: Colors.white, size: 32),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(selectedLocation.name, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Chip(label: Text("Era: ${selectedLocation.era}", style: const TextStyle(fontSize: 12)), backgroundColor: Colors.orange),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLootPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B), 
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("| Available Loot & Discoveries", style: TextStyle(color: Colors.orange, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: selectedLocation.loot.map((item) => _lootChip(item)).toList(),
          ),
          const SizedBox(height: 24),
          _historicalNote(selectedLocation.note),
        ],
      ),
    );
  }

  Widget _infoTile(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withValues(alpha:0.05), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Icon(Icons.circle, color: Colors.orange, size: 8),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16))),
        ],
      ),
    );
  }

  Widget _lootChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.white24)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 14)),
    );
  }

  Widget _historicalNote(String note) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(border: Border(left: BorderSide(color: Colors.orange, width: 4))),
      child: Text(note, style: const TextStyle(color: Colors.orange, fontSize: 14, fontStyle: FontStyle.italic)),
    );
  }

  Widget _selectionLabel(String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(border: Border.all(color: Colors.orange, width: 2), color: Colors.black),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            color: Colors.orange,
            child: Text(subtitle, style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _mapClick() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.black.withValues(alpha:0.6), border: Border.all(color: Colors.orange, width: 0.5)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Click districts to explore", style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildHeroTitle(bool isCompact) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: isCompact ? 30 : 60, horizontal: 20),
      child: Column(
        children: [
          Text(
            "Explore the World of Cavite City", 
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: isCompact ? 36 : 56, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 16),
          Text(
            "Click on each district to discover its historical significance and the challenges that awaits you", 
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: isCompact ? 15 : 18),
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
                    }
                  ),
                ),
                Expanded(
                  child: _footerCol(
                    context, 
                    "Legal", 
                    items: {
                      "Terms of Service": "popup_terms", 
                      "Privacy Policy": "popup_privacy",
                      "Cookie Policy": "/cookie"
                    }
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
                  }
                ),
                const SizedBox(height: 32),
                _footerCol(
                  context, 
                  "Legal", 
                  items: {
                    "Terms of Service": "popup_terms", 
                    "Privacy Policy": "popup_privacy",
                    "Cookie Policy": "/cookie"
                  }
                ),
              ],
            ),
          const SizedBox(height: 60),
          const Divider(color: Colors.white10),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "© 2025 Echoes of the Past. All rights reserved.",
                  style: const TextStyle(color: Colors.white24, fontSize: 12),
                  textAlign: isMobile ? TextAlign.center : TextAlign.start,
                ),
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