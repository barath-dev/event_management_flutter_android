// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:young_minds/widgets/text_input.dart';

List<String> list = <String>['Not Selected', 'Techinical', 'Non Techinical'];
List<String> list_techinical = <String>['Techinical', 'Non Techinical'];
List<String> list_non_techinical = <String>['Techinical', 'Non Techinical'];
List<String> list2 = <String>[];

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  TextEditingController event_name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController venue = TextEditingController();

  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInput(hint: 'Event Name', controller: event_name),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInput(hint: 'Description', controller: description),
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? value) => {
                setState(() {
                  if (value == 'Techinical') {
                    list2 = list_techinical;
                  }
                  if (value == 'Non Techinical') {
                    list2 = list_non_techinical;
                  }
                  dropdownValue = value!;
                })
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    // style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? value) => {
                setState(() {
                  dropdownValue = value!;
                })
              },
              items: list2.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    // style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInput(hint: 'Venue', controller: venue),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(239, 109, 77, 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                    child: Text(
                      'Create Event',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 75,
            ),
          ],
        ),
      ),
    );
  }
}
