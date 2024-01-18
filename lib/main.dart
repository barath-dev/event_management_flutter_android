import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youngmind/firebase_options.dart';
import 'package:youngmind/screens/admin/dashboard.dart';
import 'package:youngmind/screens/auth/registration_screen.dart';
import 'package:youngmind/screens/coordinator/coordinator_navigation.dart';
import 'package:youngmind/screens/student/student_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        primaryColor: Colors.blue,
        colorScheme: const ColorScheme.light(),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              if (FirebaseAuth.instance.currentUser!.uid ==
                  'eDg7yZ4D4bfPXYOzi0ZQ66CBcWM2') {
                return const CreateCoordinator();
              } else if (FirebaseAuth.instance.currentUser!.email!
                  .contains('coordinator')) {
                return const NavCoord();
              } else {
                return const NavStu();
              }
            } else if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const RegisterScreen();
        },
      ),
    );
  }
}
