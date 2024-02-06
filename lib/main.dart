import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tanist/firebase_options.dart';
import 'package:tanist/screens/home/home_screen.dart';
import 'package:tanist/screens/onboarding/onboarding_screen.dart';
import 'package:tanist/screens/onboarding/splash_screen.dart';

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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // Check if the snapshot has any data/user is logged in
            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const SplashScreen();
          }
          return const CircularProgressIndicator();
        },
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
