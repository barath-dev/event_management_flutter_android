// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youngmind/resources/DBmethods.dart';
import 'package:youngmind/screens/auth/registration_screen.dart';

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

class CreateCoordinator extends StatefulWidget {
  const CreateCoordinator({super.key});

  @override
  State<CreateCoordinator> createState() => _CreateCoordinatorState();
}

class _CreateCoordinatorState extends State<CreateCoordinator> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  void upload() async {
    if (!email.text.contains('coordinator')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a email with coordinator in it.'),
        ),
      );
      return;
    }
    var res = await DBmethods().createCoordinator(
        coordinatorEmail: email.text,
        coordinatorName: name.text,
        password: password.text,
        Institute: dropdownValue);
    if (res == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Coordinator Created'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res),
        ),
      );
    }
  }

  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Create Coordinator',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Coordinator Name',
                  border: OutlineInputBorder(),
                ),
                controller: name,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Coordinator Email',
                  border: OutlineInputBorder(),
                ),
                controller: email,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Coordinator Password',
                  border: OutlineInputBorder(),
                ),
                controller: password,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
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
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  upload();
                },
                child: const Text('Create Coordinator'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
