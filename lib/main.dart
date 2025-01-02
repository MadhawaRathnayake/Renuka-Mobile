import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:renuka_travels/auth/login_or_register.dart';
import 'package:renuka_travels/firebase_options.dart';
import 'package:renuka_travels/helper/auth_page.dart';
import 'package:renuka_travels/pages/about_us_page.dart';
import 'package:renuka_travels/pages/destinations_page.dart';
import 'package:renuka_travels/pages/featured_tours_page.dart';
import 'package:renuka_travels/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Renuka Travels',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: AuthPage(),
      routes: {
        "/loginorregister": (context) => LoginOrRegister(),
        "/home": (context) => Home(),
        "/destinations": (context) => Destinations(),
        "/featured_tours": (context) => Featured_Tours(),
        "/aboutus": (context) => AboutUs(),
      },
    );
  }
}
