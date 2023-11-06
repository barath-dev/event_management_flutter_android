import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:young_minds/widgets/event_card.dart';

class Eventist extends StatefulWidget {
  const Eventist({super.key});

  @override
  State<Eventist> createState() => _EventistState();
}

class _EventistState extends State<Eventist> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('events')
          .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return EventCard(
                  // requests: snapshot.data!.docs[index]['requests'] as List<String>,
                  myevent: true,
                  eid: snapshot.data!.docs[index]['id'],
                  url: snapshot.data!.docs[index]['imgUrl'],
                  title: snapshot.data!.docs[index]['event'],
                  description: snapshot.data!.docs[index]['description'],
                  date: snapshot.data!.docs[index]['date_time']
                      .toString()
                      .substring(0, 10),
                  time: snapshot.data!.docs[index]['date_time']
                      .toString()
                      .substring(11, 16),
                  venue: snapshot.data!.docs[index]['venue'],
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
