import 'package:flutter/material.dart';
import 'package:young_minds/resources/Authmethods.dart';
import 'package:young_minds/screens/auth/registration_screen.dart';
import 'package:young_minds/screens/common/events_feed_screen.dart';
import 'package:young_minds/widgets/text_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();

    void login() async {
      Authmethods()
          .signInUser(email: email.text, password: password.text)
          .then((value) => {
                if (value == 'success')
                  {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EventFeed()))
                  }
              });
    }

    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 20,
            child: Container(),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 24),
            child: Text(
              'Login',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 54, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 40,
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
              onTap: login,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(239, 109, 77, 1),
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                  child: Text(
                    'Login',
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
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
                child: const Text("Sign up",
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
          Flexible(
            flex: 24,
            child: Container(),
          )
        ],
      ),
    ));
  }
}
