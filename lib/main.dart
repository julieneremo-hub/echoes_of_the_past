import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

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
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
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
  User? user = FirebaseAuth.instance.currentUser;
  
  // REQUIRED: State variable for the Fog of War hover effect
  String selectedDistrict = "Hover over a district to explore";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHeroSection(),
                if (user != null) _buildCharacterDashboard(user!.uid),
                _buildMapSection(),
                _buildAboutSection(),
                _buildFooter(),
              ],
            ),
          ),
          Positioned(
            top: 0, left: 0, right: 0,
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
          const Text("EOTP LOGO", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
          Row(
            children: [
              _navLink("About"),
              _navLink("Map(Cavite)"),
              _navLink("Contact"),
            ],
          ),
          user == null ? _buildLoggedOutActions() : _buildLoggedInProfile(),
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
          image: NetworkImage('https://images.unsplash.com/photo-1518131315482-628203c90793'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("THE ULTIMATE CAVITE RPG", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
          const Text("Explore the Heart of History.", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
            onPressed: () {}, 
            child: const Text("DOWNLOAD NOW")
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                const Icon(Icons.map, size: 300, color: Colors.white12),
                _buildDistrictIcon(top: 50, left: 50, name: "Bacoor"),
                _buildDistrictIcon(top: 150, left: 100, name: "Dasmariñas"),
              ],
            ),
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(selectedDistrict, style: const TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistrictIcon({required double top, required double left, required String name}) {
    return Positioned(
      top: top, left: left,
      child: MouseRegion(
        onEnter: (_) => setState(() => selectedDistrict = "District: $name\nStatus: Fog Cleared"),
        onExit: (_) => setState(() => selectedDistrict = "Hover over a district to explore"),
        child: const Icon(Icons.location_on, color: Colors.deepOrange, size: 30),
      ),
    );
  }

  // --- HELPERS ---
  Widget _navLink(String t) => TextButton(onPressed: (){}, child: Text(t, style: const TextStyle(color: Colors.white)));
  Widget _buildLoggedOutActions() => TextButton(onPressed: (){}, child: const Text("Login"));
  Widget _buildLoggedInProfile() => const Icon(Icons.person);
  Widget _buildCharacterDashboard(String id) => Container(padding: const EdgeInsets.all(20), color: Colors.black26, child: const Text("Welcome Back, Hero"));
  Widget _buildAboutSection() => const Padding(padding: EdgeInsets.all(40), child: Text("Lore of Cavite..."));
  Widget _buildFooter() => const Padding(padding: EdgeInsets.all(20), child: Text("Footer Links"));
}