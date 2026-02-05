import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// Ensure you have initialized Firebase in your project before this
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EchoesOfThePastApp());
}

class EchoesOfThePastApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFF1A1A1A), // Dark RPG vibe [cite: 15]
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Authentication state tracking for User Flow [cite: 49, 50, 51]
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeroSection(), // The Hook [cite: 7]
                if (user != null) _buildCharacterDashboard(user!.uid), // Post-Login Dashboard [cite: 16, 17]
                _buildMapSection(), // Interactive Map [cite: 11]
                _buildAboutSection(), // Lore & Mechanics [cite: 41]
                _buildFooter(), // Technical Needs & Links [cite: 44, 48]
              ],
            ),
          ),
          // 1. Sticky Navigation Bar 
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildStickyHeader(),
          ),
        ],
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildStickyHeader() {
    return Container(
      height: 70,
      color: Colors.black.withOpacity(0.85),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("EOTP LOGO", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepOrange)), // Game Logo [cite: 3]
          Row(
            children: [
              _navLink("About"),
              _navLink("Map(Cavite)"),
              _navLink("Contact"),
            ], // Center Links [cite: 4]
          ),
          user == null ? _buildLoggedOutActions() : _buildLoggedInProfile(), // Dynamic Auth Right Side [cite: 5, 6]
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 650,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1518131315482-628203c90793'), // Replace with Cavite Vista [cite: 9]
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("THE ULTIMATE CAVITE RPG", style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, letterSpacing: 2)), [cite: 29]
          const Text("Explore the Heart of History. Reclaim the Land.", style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic)), [cite: 10]
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, padding: const EdgeInsets.all(20)),
                onPressed: () {}, 
                child: const Text("DOWNLOAD FOR WINDOWS") // Highlight Button [cite: 5, 30]
              ),
              const SizedBox(width: 20),
              OutlinedButton(onPressed: () {}, child: const Text("JOIN DISCORD")), [cite: 30]
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterDashboard(String uid) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('players').doc(uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();
        var data = snapshot.data!.data() as Map<String, dynamic>;

        return Container(
          padding: const EdgeInsets.all(30),
          color: Colors.black45,
          child: Row(
            children: [
              const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)), // 2D Character Render Placeholder [cite: 19]
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Character: ${data['username'] ?? '@Juan_Dev'}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), [cite: 24]
                  Text("Next Objective: ${data['quest'] ?? 'Defend the Shrine'}", style: const TextStyle(color: Colors.amber)), [cite: 20]
                ],
              ),
              const Spacer(),
              ElevatedButton(onPressed: () {}, child: const Text("PLAY NOW")), // Play Button [cite: 51]
            ],
          ),
        );
      },
    );
  }

  Widget _buildMapSection() {
    return Container(
      padding: const EdgeInsets.all(60),
      child: Column(
        children: [
          const Text("MAP OF CAVITE", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)), [cite: 35]
          const SizedBox(height: 10),
          const Text("Use the 'Fog of War' to explore districts.", style: TextStyle(color: Colors.grey)), [cite: 15]
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Image.network('https://example.com/stylized_cavite_map.png', height: 400), // Stylized Map [cite: 13]
                ),
              ),
              Expanded(
                child: Card(
                  color: Colors.white10,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("DISTRICT INFO", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), [cite: 36]
                        Divider(),
                        Text("Location: Tagaytay Highlands", style: TextStyle(fontSize: 18, color: Colors.blueAccent)), [cite: 37]
                        Text("Danger Level: High"), [cite: 39]
                        Text("Loot: Rare Coffee Beans, Cold Resistance"), [cite: 40]
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- HELPERS ---

  Widget _navLink(String title) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: TextButton(onPressed: () {}, child: Text(title, style: const TextStyle(color: Colors.white))),
  );

  Widget _buildLoggedOutActions() => Row(
    children: [
      TextButton(onPressed: () {}, child: const Text("Login / Register")), [cite: 5]
      const SizedBox(width: 10),
      _serverStatusIndicator(), [cite: 47]
    ],
  );

  Widget _buildLoggedInProfile() => Row(
    children: [
      const Text("@Juan_Dev", style: TextStyle(fontWeight: FontWeight.bold)), [cite: 24]
      IconButton(icon: const Icon(Icons.logout), onPressed: () => setState(() => user = null)), [cite: 6]
    ],
  );

  Widget _serverStatusIndicator() => Row(
    children: [
      const Text("Server: "),
      Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)), // Status Light [cite: 47]
    ],
  );

  Widget _buildAboutSection() => Container(
    padding: const EdgeInsets.all(60),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("ABOUT THE GAME", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        Text("Story: An alternate history where Cavite is the last bastion..."), [cite: 42]
        Text("Mechanics: Crafting, Faction Wars, Historical Quests."), [cite: 43]
      ],
    ),
  );

  Widget _buildFooter() => Container(
    padding: const EdgeInsets.all(40),
    color: Colors.black,
    child: Center(child: const Text("Support Email | Bug Report | Mirror List: Google Drive / Torrent")), [cite: 45, 48]
  );
}