import 'package:flutter/material.dart';
import 'package:young_minds/screens/services/email_services.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              EmailServices().send();
            },
            child: const Text('Test')),
      ),
    );
  }
}
