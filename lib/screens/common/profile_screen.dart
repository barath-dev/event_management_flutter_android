// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youngmind/resources/DBmethods.dart';
import 'package:youngmind/screens/auth/Registration_Screen.dart';

class ProfileScreen extends StatefulWidget {
  bool isStudent;
  ProfileScreen({super.key, required this.isStudent});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String registeredEvents = "";
  Future<String> getName() async {
    String name = await DBmethods().getName();
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(155, 158, 158, 158),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 44,
              ),
              FutureBuilder(
                future: getName(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'User Name : ${snapshot.data} ',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    );
                  } else {
                    return const Text(
                      'User Name : ',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                'User Email : ${FirebaseAuth.instance.currentUser!.email}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              widget.isStudent
                  ? FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('events')
                          .where('requests',
                              arrayContains:
                                  FirebaseAuth.instance.currentUser!.email)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            'Registered Events : ${snapshot.data?.docs.length}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          );
                        } else {
                          return const Text(
                            'Institute : ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          );
                        }
                      },
                    )
                  : Container(),
              const SizedBox(
                height: 32,
              ),
              widget.isStudent
                  ? FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('events')
                          .where('requests',
                              arrayContains:
                                  FirebaseAuth.instance.currentUser!.email)
                          .where('date_time',
                              isLessThan: DateTime.now().toString())
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            'Participted Events :${DBmethods().getParticipatedEvents()}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          );
                        } else {
                          return const Text(
                            'Participted Events : 0',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          );
                        }
                      },
                    )
                  : Container(),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
