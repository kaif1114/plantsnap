import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:plantsnap/Screens/login_screen.dart';
import 'package:plantsnap/Screens/registration_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantsnap/Screens/start_screen.dart';
import 'package:plantsnap/Screens/menu_screen.dart';
import 'package:plantsnap/widgets/Camera.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(
    MaterialApp(
      theme: ThemeData(
        backgroundColor: const Color.fromARGB(255, 237, 237, 217),
        colorScheme: ColorScheme.fromSwatch().copyWith( 
          background: const Color.fromARGB(255, 237, 237, 217),
        ),
      textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext build) {
    return const SafeArea(
      child: StartScreen(),
    );
  }
}
