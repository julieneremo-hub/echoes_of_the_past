import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';       
import 'about.dart';
import 'map.dart';
import 'char_info.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/about':
            page = AboutPage();
            break;
          case '/map':
            page = const MapPage();
            break;
          case '/char_info':
            page = CharacterInfoPage();
            break;
          case '/':
          default:
            page = const HomePage();
            break;
        }

        // Returns a custom PageRoute with smooth cross-fade duration
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 250),
        );
      },
    );
  }
}