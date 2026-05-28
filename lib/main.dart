import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'home.dart';       
import 'about.dart';
import 'map.dart';
import 'char_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const EOTPApp());
}

class EOTPApp extends StatelessWidget {
  const EOTPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EOTP - Echoes of the Past',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, 
        splashFactory: InkRipple.splashFactory, 
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),
        primaryColor: const Color(0xFFC2410C), 
        textTheme: GoogleFonts.caudexTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC2410C),
          brightness: Brightness.dark,
          primary: const Color(0xFFC2410C),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(), 
        '/about': (context) => AboutPage(),
        '/map': (context) => const MapPage(), 
        '/char_info': (context) => const CharacterInfoPage(),
      },
    );
  }
}