// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:young_minds/resources/Authmethods.dart';
import 'package:young_minds/screens/auth/login_screen.dart';
import 'package:young_minds/screens/common/events_feed_screen.dart';
import 'package:young_minds/widgets/text_input.dart';

List<String> list = <String>[
  'Select your institute',
  'G. Narayanamma Institute of Technology and Science',
  'International Institute of Information Technology (IIIT), Hyderabad',
  'Indian School of Business (ISB), Hyderabad',
  'Birla Institute of Technology and Science (BITS), Hyderabad Campus',
  'Osmania University College of Engineering (OUCE)',
  'Jawaharlal Nehru Technological University (JNTU), Hyderabad',
  'Vasavi College of Engineering',
  'Chaitanya Bharathi Institute of Technology (CBIT)',
  'Maturi Venkata Subba Rao (MVSR) Engineering College',
  'Gokaraju Rangaraju Institute of Engineering and Technology (GRIET)',
  'VNR Vignana Jyothi Institute of Engineering and Technology',
  'GITAM University, Hyderabad Campus',
  'Birla Institute of Technology and Science (BITS), Pilani - Hyderabad Campus',
  'Jawaharlal Nehru Technological University, Hyderabad (JNTUH)',
  'Osmania University (OU)',
  'SWAMI VIVEKANANDA INST OF TECHNOLOGY ,SECUNDERABAD, HYDERABAD',
  'MAHAVEER INSTITUTE OF SCI AND TECHNOLOGY, BANDLAGUDA, HYDERABAD',
  'KESHAV MEMORIAL INST OF TECHNOLOGY NARAYANAGUDA, HYDERABAD'
];

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController institute = TextEditingController();
    TextEditingController passingOutYear = TextEditingController();
    TextEditingController uniqueId = TextEditingController();

    String dropdownValue = list.first;

    void register() async {
      if (email.text.isNotEmpty &&
          password.text.isNotEmpty &&
          name.text.isNotEmpty &&
          dropdownValue != 'Select your institute' &&
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

    @override
    void didChangeAppLifecycleState(AppLifecycleState state) {
      if (state == AppLifecycleState.paused) {
        FocusScope.of(context).requestFocus(FocusNode());
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
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    itemHeight: 75,
                    isExpanded: true,
                    value: dropdownValue,
                    onChanged: (String? value) => {
                      setState(() {
                        dropdownValue = value!;
                      })
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Column(children: [
                          Container(
                            child: Text(
                              value,
                              softWrap: true,
                              // style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ]),
                      );
                    }).toList(),
                  ),
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
