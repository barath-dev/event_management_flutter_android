// ignore_for_file: use_build_context_synchronously

import "package:flutter/material.dart";
import "package:youngmind/resources/Authmethods.dart";
import "package:youngmind/screens/auth/login_screen.dart";
import "package:youngmind/screens/student/student_navigation.dart";
import "package:youngmind/widgets/text_input.dart";

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

List<String> passingOutYearList = [
  'Select your passing out year',
  DateTime.now().year.toString(),
  (DateTime.now().year + 1).toString(),
  (DateTime.now().year + 2).toString(),
  (DateTime.now().year + 3).toString(),
  (DateTime.now().year + 4).toString(),
  (DateTime.now().year + 5).toString(),
  (DateTime.now().year + 6).toString(),
];

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController institute = TextEditingController();
  TextEditingController passingOutYear = TextEditingController();
  TextEditingController uniqueId = TextEditingController();
  late String dropdownValue;
  late String passOut;

  @override
  void initState() {
    dropdownValue = list.first;
    passOut = passingOutYearList.first;
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    institute.dispose();
    passingOutYear.dispose();
    uniqueId.dispose();
    super.dispose();
  }

  void register() async {
    if (email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        name.text.isNotEmpty &&
        dropdownValue != 'Select your institute' &&
        uniqueId.text.isNotEmpty) {
      String result = await Authmethods().signUpuser(
          year: int.parse(passOut),
          email: email.text,
          password: password.text,
          name: name.text,
          institute: dropdownValue,
          // passingOutYear: passingOutYear.text,
          uniqueId: uniqueId.text);
      if (result == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful')));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const NavStu()));
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: TextInput(
            //     hint: 'Passing out Year',
            //     controller: passingOutYear,
            //     keybordType: TextInputType.number,
            //   ),
            // ),
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
                      Text(
                        value,
                        softWrap: true,
                        // style: TextStyle(color: Colors.white),
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
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                itemHeight: 75,
                isExpanded: true,
                value: passOut,
                onChanged: (String? value) => {
                  setState(() {
                    passOut = value!;
                  })
                },
                items: passingOutYearList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Column(children: [
                      Text(
                        value,
                        softWrap: true,
                        // style: TextStyle(color: Colors.white),
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
                      color: const Color.fromRGBO(239, 109, 77, 1),
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
          ],
        ),
      ),
    ));
  }
}
