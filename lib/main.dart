import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:young_minds/firebase_options.dart';
import 'package:young_minds/screens/admin/dashboard.dart';
import 'package:young_minds/screens/auth/create_account.dart';
import 'package:young_minds/screens/auth/registration_screen.dart';
import 'package:young_minds/screens/coordinator/coordinator_navigation.dart';
import 'package:young_minds/screens/student/student_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
                  'blMCKYP9VeRMk5d0Nla3neeeOMu1') {
                return const CreateCoordinator();
              } else if (FirebaseAuth.instance.currentUser!.email!
                  .contains('@coordinator')) {
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
