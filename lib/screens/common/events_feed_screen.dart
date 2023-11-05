import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          title: const Text(
            'Event Feed',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: const SingleChildScrollView(
            child: Column(
                children: [
              EventCard(
                title: 'Event Name',
                description: 'Event Description',
                venue: 'Event Venue',
                date: 'Event Date',
                time: 'Event Time',
              )
            ])));
  }
}
