// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youngmind/screens/coordinator/email_screen.dart';
import 'package:youngmind/screens/coordinator/requests.dart';
import 'package:youngmind/screens/coordinator/send_notification_scree.dart';

class EventCard extends StatefulWidget {
  final String title;
  final String description;
  final String venue;
  final String date;

  final bool myevent;
  // final bool isRegistered;
  final String url;
  final String link;
  final String time;
  final bool isParticipated;
  final dynamic requests;
  // final List<String> requests;
  final String eid;

  const EventCard(
      {super.key,
      required this.title,
      required this.requests,
      required this.description,
      required this.url,
      required this.myevent,
      // required this.isRegistered,
      required this.link,
      required this.isParticipated,
      required this.venue,
      required this.eid,
      required this.date,
      required this.time});

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool willing = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 4), blurRadius: 5)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(widget.url),
                  )),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              widget.title,
              softWrap: true,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              widget.description,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.venue,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.date,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.time,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            // ignore: prefer_interpolation_to_compose_strings
            widget.requests.length.toString() + " people interested",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 42,
          ),
          !widget.myevent
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    print(widget.eid);
                    print(FirebaseAuth.instance.currentUser!.email);
                    if (widget.myevent) {
                      // EmailServices().send(widget.requests);
                    } else {
                      FirebaseFirestore.instance
                          .collection('events')
                          .doc(widget.eid)
                          .update({
                        'requests': FieldValue.arrayUnion(
                            [FirebaseAuth.instance.currentUser!.email])
                      });
                      FirebaseFirestore.instance
                          .collection('notifications')
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .update({
                        'notifications': FieldValue.arrayUnion([
                          {
                            'title': 'Registered for ${widget.title}',
                            'description':
                                'You have successfully registered for ${widget.title}'
                          }
                        ])
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Registered')));
                    }
                  },
                  child: const Text("Intrested",
                      style: TextStyle(color: Colors.white)))
              : const Text(''),
          widget.myevent
              ? ElevatedButton(
                  onPressed: () {
                    print(widget.eid);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewRequests(
                                  eid: widget.eid,
                                )));
                  },
                  child: const Text('View interstead students'))
              : Container(),
          widget.myevent
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmailScreen(
                                  emails: widget.requests,
                                )));
                  },
                  child: const Text('Send confirmation email'))
              : Container(),
          widget.myevent
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SendNotification(
                                  requests: widget.requests,
                                )));
                  },
                  child: const Text('Send confirmation notification'))
              : Container(),
          widget.isParticipated
              ? ElevatedButton(
                  onPressed: () {
                    launchUrl(widget.link as Uri);
                  },
                  child: const Text('Send confirmation notification'))
              : Container()
        ],
      ),
    );
  }
}
