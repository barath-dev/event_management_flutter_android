import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:young_minds/screens/auth/registration_screen.dart';
import 'package:young_minds/widgets/event_card.dart';

class EventFeed extends StatefulWidget {
  const EventFeed({super.key});

  @override
  State<EventFeed> createState() => _EventFeedState();
}

class _EventFeedState extends State<EventFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()));
                },
                icon: const Icon(Icons.logout_rounded))
          ],
          title: const Text(
            'Event Feed',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('events').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return EventCard(
                      requests: snapshot.data!.docs[index]['requests'],
                      myevent: false,
                      // requests: snapshot.data!.docs[index]['requests'],
                      eid: snapshot.data!.docs[index]['eid'],
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
        ));
  }
}
