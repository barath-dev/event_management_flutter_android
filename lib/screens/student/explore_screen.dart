// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_element, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youngmind/widgets/event_card.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  String _searchText = "";
  String _field = "event";

  bool isRegistered = false;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    // bool isShowUsers = false;

    @override
    void dispose() {
      _searchController.dispose();
      super.dispose();
    }

    _pickField() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Search by"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: const Text("Event"),
                      onTap: () {
                        setState(() {
                          _field = "event";
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: const Text("Venue"),
                      onTap: () {
                        setState(() {
                          _field = "venue";
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                    const Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: const Text("Description"),
                      onTap: () {
                        setState(() {
                          _field = "description";
                        });
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          title: TextFormField(
              controller: _searchController,
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                labelText: 'Search',
              ),
              onFieldSubmitted: (val) {
                setState(() {
                  _searchText = _searchController.text;
                });
                print(_searchText);
              }),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _searchText = "";
                  _searchController.clear();
                });
              },
              icon: const Icon(Icons.clear),
            ),
            IconButton(
              onPressed: () {
                _pickField();
              },
              icon: const Icon(Icons.filter_alt_rounded),
            )
          ],
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('events')
              .where(_field, isGreaterThanOrEqualTo: _searchText)
              .where(_field, isLessThan: '${_searchText}z')
              .orderBy(_field)
              .get(),
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
              print("entered");
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
                      venue: snapshot.data!.docs[index]['venue'],
                      isParticipated: false,
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
