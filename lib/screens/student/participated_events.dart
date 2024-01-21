import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youngmind/widgets/event_card.dart';

class PartcipatedEvents extends StatefulWidget {
  const PartcipatedEvents({super.key});

  @override
  State<PartcipatedEvents> createState() => _PartcipatedEventsState();
}

class _PartcipatedEventsState extends State<PartcipatedEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Participated Events'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('events')
              .where('date_time', isLessThanOrEqualTo: Timestamp.now())
              .where('requests',
                  arrayContains: FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
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
                    return EventCard(
                      link: snapshot.data!.docs[index]['link'],
                      requests: snapshot.data!.docs[index]['requests'],
                      myevent: false,
                      eid: snapshot.data!.docs[index]['eid'],
                      url: snapshot.data!.docs[index]['imgUrl'],
                      title: snapshot.data!.docs[index]['event'],
                      description: snapshot.data!.docs[index]['description'],
                      date: snapshot.data!.docs[index]['date_time']
                          .toString()
                          .substring(10, 18),
                      time: DateTime.fromMillisecondsSinceEpoch(
                              snapshot.data!.docs[index]['date_time'].seconds *
                                  1000)
                          .toString()
                          .substring(11, 19),
                      venue: snapshot.data!.docs[index]['venue'],
                      isParticipated: true,
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
