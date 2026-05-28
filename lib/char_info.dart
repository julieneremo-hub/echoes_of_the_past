import 'package:flutter/material.dart';
import 'auth_popup.dart';

class CharacterInfoPage extends StatefulWidget {
  const CharacterInfoPage({super.key});

  @override
  State<CharacterInfoPage> createState() => _CharacterInfoPageState();
}

class _CharacterInfoPageState extends State<CharacterInfoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Detect viewport constraints dynamically (matched with home.dart layout specs)
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 950;
    final bool isNarrowScreen = screenWidth < 900;
    final bool isMobileFooter = screenWidth < 700;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      // Collapsible drawer menu active during narrow window views
      endDrawer: isMobile
          ? Drawer(
              backgroundColor: const Color(0xFF0F172A),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                children: [
                  _drawerNavLink("Home", "/"),
                  _drawerNavLink("About", "/about"),
                  _drawerNavLink("Map", "/map"),
                  _drawerNavLink("Character Info", "/char_info", isActive: true),
                  _drawerNavLink("Login", "/auth_popup"),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download_rounded, size: 18, color: Colors.white),
                    label: const Text("Download Game", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC2410C),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            )
          : null,
      body: CustomScrollView(
        slivers: [
          // HEADER - Matches home.dart exactly
          SliverAppBar(
            backgroundColor: Colors.black.withOpacity(0.9),
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
                  _navLink(context, "Login", "/auth_popup"),
                  const SizedBox(width: 20),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download_rounded, size: 18, color: Colors.white),
                    label: const Text("Download Game", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC2410C),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ],
            ),
          ),

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
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    "Meet the heroes who journey through time to uncover the truth about Cavite City's forgotten history",
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

                // CHARACTER CARDS SECTION
                _contentWrapper(
                  screenWidth: screenWidth,
                  sectionContent: Center(
                    child: Wrap(
                      spacing: 30,
                      runSpacing: 30,
                      alignment: WrapAlignment.center,
                      children: [
                        _characterCard(
                          screenWidth: screenWidth,
                          name: "Leandro Vergara",
                          role: "Modern Historian",
                          gender: "Male",
                          time: "Present (2025)",
                          description:
                              "A dedicated historian searching for the truth about Cavite City's past. His discovery of the mysterious time machine in a hidden library sets everything in motion.",
                          imageUrl: "assets/leandro.png",
                          accentColor: const Color(0xFF3B82F6),
                        ),
                        _characterCard(
                          screenWidth: screenWidth,
                          name: "Emilia Legaspi",
                          role: "Modern Researcher",
                          gender: "Female",
                          time: "Present (2025)",
                          description:
                              "A skilled researcher with a passion for uncovering hidden historical truths. She joins the journey to document the untold stories of Cavite City's heritage.",
                          imageUrl: "assets/emilia.png",
                          accentColor: const Color(0xFF3B82F6),
                        ),
                        _characterCard(
                          screenWidth: screenWidth,
                          name: "Marcelino Fuentes",
                          role: "Historical Figure",
                          gender: "Male",
                          time: "Past (1896)",
                          description:
                              "A witness to the defining moments of Cavite City during the Spanish colonization. His memories are stored, waiting to be experienced.",
                          imageUrl: "assets/marcelino.png",
                          accentColor: const Color(0xFFFB923C),
                        ),
                        _characterCard(
                          screenWidth: screenWidth,
                          name: "Dolores Lazcano",
                          role: "Historical Figure",
                          gender: "Female",
                          time: "Past (1896)",
                          description:
                              "A courageous resident of Cavite City whose experiences during the Spanish era reveal the struggles and resilience of the city's people.",
                          imageUrl: "assets/dolores.png",
                          accentColor: const Color(0xFFFB923C),
                        ),
                      ],
                    ),
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
                                "Leandro Vergara/Emilia Legaspi discover a hidden library with a mysterious time machine. Memory containers hold recorded memories of Cavite City's significant historical events, ready to be experienced.",
                                const Color(0xFF1E293B),
                                const Color(0xFF3B82F6),
                                isFullWidth: true),
                            const SizedBox(height: 20),
                            _journeyCard(
                                "Historical Acts (1571-1935)",
                                "Experience six scripted narrative acts through the eyes of Marcelino Fuentes and Dolores Lazcano. Witness the Spanish naval port, Cavite Mutiny, Gomburza execution, Philippine Independence, and more.",
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
                              "Leandro Vergara/Emilia Legaspi discover a hidden library with a mysterious time machine. Memory containers hold recorded memories of Cavite City's significant historical events, ready to be experienced.",
                              const Color(0xFF1E293B),
                              const Color(0xFF3B82F6),
                            ),
                            const SizedBox(width: 30),
                            _journeyCard(
                              "Historical Acts (1571-1935)",
                              "Experience six scripted narrative acts through the eyes of Marcelino Fuentes and Dolores Lazcano. Witness the Spanish naval port, Cavite Mutiny, Gomburza execution, Philippine Independence, and more.",
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

  // --- Helper Widgets ---

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

  Widget _characterCard({
    required double screenWidth,
    required String name,
    required String role,
    required String gender,
    required String time,
    required String description,
    required String imageUrl,
    required Color accentColor,
  }) {
    double cardWidth = (screenWidth - 150) / 2;
    if (cardWidth > 580) cardWidth = 580;
    if (screenWidth < 900) cardWidth = double.infinity;

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: screenWidth < 500 ? 260 : 400,
                width: double.infinity,
                color: Colors.grey[900],
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 100, color: Colors.white10);
                  },
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: accentColor.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: accentColor, size: 16),
                      const SizedBox(width: 8),
                      Text(time, style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(color: accentColor, fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(gender == "Male" ? Icons.person : Icons.person_3, color: Colors.white38, size: 18),
                        const SizedBox(width: 4),
                        Text(gender, style: const TextStyle(color: Colors.white38)),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on, color: Colors.white38, size: 18),
                        const SizedBox(width: 4),
                        Text(role, style: const TextStyle(color: Colors.white38)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(description, style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.5)),
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
        border: Border.all(color: accentColor.withOpacity(0.5), width: 2),
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
        onTap: () {
          if (route == "/auth_popup") {
            showDialog(
                context: context,
                barrierColor: Colors.black87,
                builder: (context) => const AuthPopup());
          } else {
            Navigator.of(context).pushNamed(route);
          }
        },
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
        Navigator.pop(context); // Close sliding drawer overlay
        if (route == "/auth_popup") {
          showDialog(
            context: context,
            barrierColor: Colors.black87,
            builder: (context) => const AuthPopup(),
          );
        } else {
          Navigator.of(context).pushNamed(route);
        }
      },
    );
  }
}

class FooterSection extends StatelessWidget {
  final bool isMobile;
  const FooterSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.fromLTRB(60, 80, 60, 40),
      child: Column(
        children: [
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _footerCol(context, "Echoes of the Past", [
                "An immersive educational role-playing game about the history and cultural heritage of Cavite City through scripted narrative acts and historical investigation."
              ], isLarge: !isMobile, isFullWidth: isMobile),
              if (isMobile) const SizedBox(height: 24),
              _footerCol(context, "Game", ["Home", "About", "Map", "Character Info"], isFullWidth: isMobile),
              if (isMobile) const SizedBox(height: 24),
              _footerCol(context, "Support", ["FAQ", "System Requirements"], isFullWidth: isMobile),
              if (isMobile) const SizedBox(height: 24),
              _footerCol(context, "Legal", ["Terms of Service", "Privacy Policy", "Cookie Policy", "Licenses"], isFullWidth: isMobile),
            ],
          ),
          const SizedBox(height: 60),
          const Divider(color: Colors.white10),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text("© 2025 Echoes of the Past. All rights reserved.",
                    style: TextStyle(color: Colors.white24, fontSize: 12)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _footerCol(BuildContext context, String title, List<String> items, {bool isLarge = false, bool isFullWidth = false}) {
    final Map<String, String> routeMap = {
      "Home": "/",
      "About": "/about",
      "Map": "/map",
      "Character Info": "/char_info",
    };

    final Widget columnContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        ...items.map((item) {
          final String? route = routeMap[item];

          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: InkWell(
              onTap: route != null ? () => Navigator.of(context).pushNamed(route) : null,
              mouseCursor: route != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
              child: Text(
                item,
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }),
      ],
    );

    if (isFullWidth) return columnContent;

    return Expanded(
      flex: isLarge ? 2 : 1,
      child: columnContent,
    );
  }
}