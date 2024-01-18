// ignore_for_file: unused_element, no_leading_underscores_for_local_identifiers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youngmind/widgets/event_card.dart';

class EventFeed extends StatefulWidget {
  const EventFeed({super.key});

  @override
  State<EventFeed> createState() => _EventFeedState();
}

class _EventFeedState extends State<EventFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('events')
          .where('date_time', isLessThanOrEqualTo: Timestamp.now())
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No Events'),
            );
          }
          print(snapshot.data!.docs.length);

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                print(index);

                if (snapshot.data!.docs[index]['requests']
                    .contains(FirebaseAuth.instance.currentUser!.email)) {
                  print(snapshot.data!.docs[index]['requests']);
                  if (index == snapshot.data!.docs.length - 1) {
                    return Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2.5),
                      child: const Center(
                        child: Text(
                          'Registered for all events !',
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
                    );
                  }
                  return Container();
                }
                return EventCard(
                  link: snapshot.data!.docs[index]['link'],
                  isParticipated: false,
                  myevent: false,
                  requests: snapshot.data!.docs[index]['requests'],
                  eid: snapshot.data!.docs[index]['eid'],
                  url: snapshot.data!.docs[index]['imgUrl'],
                  title: snapshot.data!.docs[index]['event'],
                  description: snapshot.data!.docs[index]['description'],
                  venue: snapshot.data!.docs[index]['venue'],
                  date: DateTime.fromMillisecondsSinceEpoch(
                          snapshot.data!.docs[index]['date_time'].seconds *
                              1000)
                      .toString()
                      .substring(0, 10),
                  time: DateTime.fromMillisecondsSinceEpoch(
                          snapshot.data!.docs[index]['date_time'].seconds *
                              1000)
                      .toString()
                      .substring(11, 19),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
