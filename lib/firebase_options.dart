import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return web;
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBVlRvnWjikzOA_OWMVPEOLKGnlXVMYXf0',
    appId: '1:790540243650:web:e3d953c9244c9c81d8215b',
    messagingSenderId: '790540243650',
    projectId: 'echoes-of-the-past-f27ca',
    authDomain: 'echoes-of-the-past-f27ca.firebaseapp.com',
    storageBucket: 'echoes-of-the-past-f27ca.firebasestorage.app',
    measurementId: 'G-13VMLRCH6T',
  );
}