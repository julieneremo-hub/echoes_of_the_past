import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'faq_popup.dart';
import 'contact_popup.dart';
import 'terms_of_service_popup.dart';
import 'privacy_popup.dart';
import 'sys_req_popup.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Helper method to open the game URL in a new browser tab
  Future<void> _launchGameUrl() async {
    final Uri gameUrl = Uri.parse('https://your-game-url.com'); // Replace with your actual game URL
    if (!await launchUrl(gameUrl, webOnlyWindowName: '_blank')) {
      debugPrint('Could not launch $gameUrl');
    }
  }

  void _handleSubscribe() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Thank you for subscribing, ${_emailController.text}!'),
          backgroundColor: const Color(0xFFC2410C),
        ),
      );
      _emailController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 950;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      endDrawer: isMobile ? _buildDrawer(context) : null,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, isMobile),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildHeroSection(context, isMobile),
                _buildFeaturesSection(isMobile),
                _buildSubscribeSection(isMobile),
                FooterSection(isMobile: isMobile),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // APP BAR & NAVIGATION COMPONENTS

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
            children: [
              Text("Echoes of the Past", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              Text("History & Culture of Cavite City", style: TextStyle(fontSize: 10, color: Color(0xFFFB923C))),
            ],
          ),
          if (!isMobile) ...[
            const Spacer(),
            _navLink(context, "Home", "/", isActive: true),
            _navLink(context, "About", "/about"),
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
          _drawerNavLink("Home", "/", isActive: true),
          _drawerNavLink("About", "/about"),
          _drawerNavLink("Map", "/map"),
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

  // PAGE SECTION BUILDERS

  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 40),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/hero_bg.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Echoes of the Past",
            textAlign: TextAlign.center,
            style: TextStyle(color: const Color(0xFFF97316), fontSize: isMobile ? 44 : 80, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "A role-playing game about the history and cultural heritage of Cavite City",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: isMobile ? 16 : 22),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 200),
            child: Text(
              "Uncover the hidden truth of Cavite City through a mysterious time machine that sends you into the past itself.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: isMobile ? 14 : 18, height: 1.5),
            ),
          ),
          const SizedBox(height: 60),
          const Icon(Icons.mouse_outlined, color: Colors.white54, size: 32),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(bool isMobile) {
    return _contentWrapper(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 60, vertical: 60),
      sectionContent: Wrap(
        spacing: 32,
        runSpacing: 32,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _featureCard(Icons.access_time, "Time Machine", "Experience history directly through a mysterious machine."),
          _featureCard(Icons.map_outlined, "Historical Locations", "Explore Cavite City's port, Fort San Felipe, and the Cavite Arsenal."),
          _featureCard(Icons.psychology_outlined, "Historical Events", "Witness the Galleon Trade, Cavite Mutiny, and pivotal moments in history."),
          _featureCard(Icons.visibility_outlined, "Memory Fragments", "Glass containers storing memories of Cavite's defining moments."),
        ],
      ),
    );
  }

  Widget _buildSubscribeSection(bool isMobile) {
    return _contentWrapper(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 60, vertical: 60),
      sectionContent: Container(
        padding: EdgeInsets.all(isMobile ? 32 : 80),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white10),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(Icons.mail_outline, color: Color(0xFFF97316), size: 50),
              const SizedBox(height: 20),
              Text(
                "Subscribe for the Latest News & Updates",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: isMobile ? 26 : 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              if (!isMobile)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 450, child: _buildEmailTextField()),
                    const SizedBox(width: 20),
                    _buildSubscribeButton(isFullWidth: false),
                  ],
                )
              else
                Column(
                  children: [
                    _buildEmailTextField(),
                    const SizedBox(height: 16),
                    _buildSubscribeButton(isFullWidth: true),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      controller: _emailController,
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter your email';
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Please enter a valid email address';
        return null;
      },
      decoration: InputDecoration(
        hintText: "Enter your email address",
        hintStyle: const TextStyle(color: Colors.white24),
        filled: true,
        fillColor: Colors.black26,
        errorStyle: const TextStyle(color: Color(0xFFFB923C)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white10),
        ),
      ),
    );
  }

  Widget _buildSubscribeButton({required bool isFullWidth}) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: _handleSubscribe,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF97316),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text("Subscribe", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _contentWrapper({required Widget sectionContent, EdgeInsets? padding}) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 60, vertical: 100),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: sectionContent,
        ),
      ),
    );
  }

  Widget _featureCard(IconData icon, String title, String desc) {
    return Container(
      width: 260,
      height: 280,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFF97316), size: 40),
          const SizedBox(height: 16),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 10),
          Text(desc, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white54, fontSize: 14)),
        ],
      ),
    );
  }
}

// FOOTER SECTION
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
                _footerCol(context, "Game",
                  items: {
                    "Home": "/",
                    "About": "/about",
                    "Map": "/map",
                    "Character Info": "/char_info"
                  },
                ),
                const SizedBox(height: 32),
                _footerCol(context, "Support", 
                  items: {
                    "FAQ": "popup_faq",
                    "Contact Us": "popup_contact",
                    "System Requirements": "popup_sys_req",
                  }
                ),
                const SizedBox(height: 32),
                _footerCol(context, "Legal", 
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