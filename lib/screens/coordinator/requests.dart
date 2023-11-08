import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:young_minds/widgets/event_card.dart';

class ViewRequests extends StatefulWidget {
  final String eid;
  const ViewRequests({super.key, required this.eid});

  @override
  State<ViewRequests> createState() => _ViewRequestsState();
}

class _ViewRequestsState extends State<ViewRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('events')
          .doc(widget.eid)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        print('aa');
        if (snapshot.hasData) {
          print('data');
          if (snapshot.data!['requests'].isEmpty) {
            return const Center(
              child: Text('No requests yet'),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!['requests'].length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data!['requests'][index].toString()),
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
