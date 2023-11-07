// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  final String title;
  final String description;
  final String venue;
  final String date;
  final bool myevent;
  final String url;
  final String time;
  // final List<String> requests;
  final String eid;

  const EventCard(
      {super.key,
      required this.title,
      required this.description,
      required this.url,
      required this.myevent,
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
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 4), blurRadius: 5)
          ]),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(widget.url),
                )),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                softWrap: true,
                style:
                    const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.description,
                style: const TextStyle(fontSize: 18),
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
              TextButton(
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
                      setState(() {
                        willing = true;
                      });
                    }
                  },
                  child: Text(widget.myevent
                      ? 'Send confirmation Mail'
                      : willing
                          ? "You will be notified"
                          : "Intrested"))
            ],
          ),
        ],
      ),
    );
  }
}
