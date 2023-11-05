// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:young_minds/resources/Authmethods.dart';
import 'package:young_minds/screens/auth/login_screen.dart';
import 'package:young_minds/screens/common/events_feed_screen.dart';
import 'package:young_minds/widgets/text_input.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController institute = TextEditingController();
    TextEditingController passingOutYear = TextEditingController();
    TextEditingController uniqueId = TextEditingController();

    void register() async {
      if (email.text.isNotEmpty &&
          password.text.isNotEmpty &&
          name.text.isNotEmpty &&
          institute.text.isNotEmpty &&
          passingOutYear.text.isNotEmpty &&
          uniqueId.text.isNotEmpty) {
        String result = await Authmethods().signUpuser(
            email: email.text,
            password: password.text,
            name: name.text,
            institute: institute.text,
            passingOutYear: passingOutYear.text,
            uniqueId: uniqueId.text);
        if (result == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration Successful')));
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const EventFeed()));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(result)));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill all the fields')));
      }
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    'Register',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 54, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput(hint: 'name', controller: name),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput(hint: 'email address', controller: email),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput(
                    hint: 'Passing out Year',
                    controller: passingOutYear,
                    keybordType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput(
                      hint: 'Institution Name', controller: institute),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput(hint: 'Unique ID', controller: uniqueId),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInput(
                    hint: 'Password',
                    controller: password,
                    isPassword: true,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: InkWell(
                    onTap: register,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(239, 109, 77, 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
              ])),
    ));
  }
}
