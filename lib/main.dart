import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(EchoesOfThePastApp());

class EchoesOfThePastApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepOrange,
        scaffoldBackgroundColor: Color(0xFF1A1A1A), // Dark RPG vibe [cite: 15]
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
  final User? user = FirebaseAuth.instance.currentUser;

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
          _buildStickyHeader(), // Positioned at top 
        ],
      ),
    );
  }

  // 1. Sticky Navigation Bar [cite: 1, 2]
  Widget _buildStickyHeader() {
    return Container(
      height: 70,
      color: Colors.black.withOpacity(0.8),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("LOGO", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), // [cite: 3]
          Row(
            children: [
              _navLink("About"),
              _navLink("Map(Cavite)"),
              _navLink("Contact"),
            ],
          ), // [cite: 4]
          user == null ? _buildLoggedOutButtons() : _buildLoggedInProfile(), // 
        ],
      ),
    );
  }

  // 2. The Hero Section [cite: 7, 10]
  Widget _buildHeroSection() {
    return Container(
      height: 600,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://example.com/aguinaldo_shrine.jpg'), // [cite: 9]
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("THE ULTIMATE CAVITE RPG", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)), // [cite: 29]
          Text("Explore the Heart of History. Reclaim the Land.", style: TextStyle(fontSize: 20)), // [cite: 10]
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("DOWNLOAD FOR WINDOWS")), // [cite: 30]
              SizedBox(width: 20),
              OutlinedButton(onPressed: () {}, child: Text("JOIN DISCORD")),
            ],
          ),
        ],
      ),
    );
  }

  // 4. The RPG Character Dashboard (Post-Login) [cite: 16]
  Widget _buildCharacterDashboard(String uid) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('players').doc(uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        var data = snapshot.data!;

        return Container(
          padding: EdgeInsets.all(40),
          color: Colors.black38,
          child: Row(
            children: [
              CircleAvatar(radius: 50, backgroundImage: NetworkImage(data['avatar_url'])), // [cite: 19]
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome back, ${data['username']}", style: TextStyle(fontSize: 24)), // [cite: 24]
                  Text("Quest Log: ${data['next_objective']}", style: TextStyle(color: Colors.amber)), // [cite: 20]
                ],
              ),
              Spacer(),
              _serverStatusIndicator(), // 
            ],
          ),
        );
      },
    );
  }

  // 3. The Interactive Map Section [cite: 11]
  Widget _buildMapSection() {
    return Container(
      padding: EdgeInsets.all(50),
      child: Column(
        children: [
          Text("MAP OF CAVITE", style: TextStyle(fontSize: 32)), // [cite: 35]
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: Placeholder(fallbackHeight: 400)), // Interactive Map Graphic [cite: 37]
              Expanded(
                child: Column(
                  children: [
                    Text("Tagaytay Highlands", style: TextStyle(fontSize: 24, color: Colors.blue)), // [cite: 37]
                    Text("Danger Level: High"), // [cite: 39]
                    Text("Loot: Rare Coffee Beans, Cold Resistance"), // [cite: 40]
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper Widgets
  Widget _navLink(String title) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 15),
    child: TextButton(onPressed: () {}, child: Text(title, style: TextStyle(color: Colors.white))),
  );

  Widget _buildLoggedOutButtons() => Row(
    children: [
      TextButton(onPressed: () {}, child: Text("Login / Register")),
      ElevatedButton(onPressed: () {}, child: Text("Download Game")),
    ],
  );

  Widget _buildLoggedInProfile() => Row(
    children: [
      Text("@Juan_Dev"),
      IconButton(icon: Icon(Icons.logout), onPressed: () {}),
    ],
  );

  Widget _serverStatusIndicator() => Row(
    children: [
      Text("Server Status: "),
      Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle)), // 
    ],
  );

  Widget _buildAboutSection() => Container(padding: EdgeInsets.all(40), child: Text("Story: An alternate history where Cavite...")); // [cite: 42]
  Widget _buildFooter() => Container(height: 100, child: Center(child: Text("Support Email | Bug Report | Privacy Policy"))); // [cite: 45]
}