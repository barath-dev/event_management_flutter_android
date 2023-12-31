// ignore_for_file: non_constant_identifier_names, avoid_print, unused_element, prefer_const_constructors

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:young_minds/resources/DBmethods.dart';
import 'package:young_minds/resources/StorageMethods.dart';
import 'package:young_minds/utils/utils.dart';
import 'package:young_minds/widgets/text_input.dart';
import 'package:image_picker/image_picker.dart';

List<String> list = <String>['Not Selected', 'Techinical', 'Non Techinical'];
List<String> list_techinical = <String>[
  '	Hackathons',
  'Technical Quiz',
  'Technical seminars',
  'Technical conference',
  'Technical workshops',
  'Paper presentation',
  'Poster presentations',
  'Idea pitching'
];
List<String> list_non_techinical = <String>[
  'quiz',
  'cultural fests',
  'seminars',
  'sports',
  'treasure hunt'
];
List<String> Unit = <String>['Choose', 'Days', 'Hours'];

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  DateTime selectedExpiryDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime selectedPickupDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  TextEditingController event_name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController venue = TextEditingController();
  TextEditingController duration = TextEditingController();
  String unit = Unit.first;
  String event_type = '';

  String dropdownValue = list.first;

  _ChooseEvent() {
    if (dropdownValue == 'Techinical') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Choose Event'),
              content: SizedBox(
                height: 200,
                width: 200,
                child: ListView.builder(
                  itemCount: list_techinical.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(list_techinical[index]),
                      onTap: () {
                        setState(() {
                          event_type = list_techinical[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            );
          });
    } else if (dropdownValue == 'Non Techinical') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Choose Event'),
              content: SizedBox(
                height: 200,
                width: 200,
                child: ListView.builder(
                  itemCount: list_non_techinical.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(list_non_techinical[index]),
                      onTap: () {
                        setState(() {
                          event_type = list_techinical[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            );
          });
    }
    if (dropdownValue == 'Not Selected') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('Choose Event'),
              content: Text('Please Select Event Type'),
            );
          });
    }
  }

  Uint8List? _file;
  bool _filepicked = false;
  String url = '';

  Future<void> uploadImage() async {
    print('uploading image');
    StorageMethods storageMethods = StorageMethods();
    url = await storageMethods.uploadImagetoStorage(_file!);
    print('upload image success');
    print(url);
  }

  void _selectImage() async {
    Uint8List image = await PickImage(ImageSource.gallery);
    _filepicked = true;
    setState(() {
      _file = image;
      print('image selected');
    });
  }

  Future<void> uploadEvent() async {
    print('uploading event');
    String result = await DBmethods().uploadEvent(
      inst: FirebaseAuth.instance.currentUser!.uid,
      type: dropdownValue,
      event: event_type,
      description: description.text,
      date_time: selectedPickupDate.toString(),
      venue: venue.text,
      duration: duration.text,
      imgUrl: url,
      id: FirebaseAuth.instance.currentUser!.uid,
    );
    print(result);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        initialDate: DateTime.now());

    Future<TimeOfDay?> pickTime() =>
        showTimePicker(context: context, initialTime: TimeOfDay.now());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Event',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            !(_filepicked)
                ? const CircleAvatar(
                    backgroundColor: Color.fromARGB(0, 0, 0, 0),
                    backgroundImage: AssetImage('assets/images/add.jpg'),
                    radius: 50,
                  )
                : CircleAvatar(
                    backgroundColor: const Color.fromARGB(0, 0, 0, 0),
                    backgroundImage: MemoryImage(_file!),
                    radius: 50,
                  ),
            TextButton(
                onPressed: () {
                  print('tapped');
                  _selectImage();
                },
                child: Text('Upload Image')),
            const SizedBox(
              height: 10,
            ),
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
            const Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Event Category',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String? value) => {
                    setState(() {
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
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        _ChooseEvent();
                      },
                      child:
                          Text(event_type == '' ? 'Choose Event' : event_type)),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Text(
                    'Date time:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () async {
                        final date = await pickDate();
                        final time = await pickTime();
                        if (date == null) return;
                        if (time == null) return;

                        setState(() {
                          selectedPickupDate = date;
                          selectedPickupDate = DateTime(
                              selectedPickupDate.year,
                              selectedPickupDate.month,
                              selectedPickupDate.day,
                              time.hour,
                              time.minute);
                        });
                      },
                      child: Text(
                          "${selectedPickupDate.year}/${selectedPickupDate.month}/${selectedPickupDate.day}  ${selectedPickupDate.hour}:${selectedPickupDate.minute}")),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInput(hint: 'Venue', controller: venue),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Spacer(),
                TextInput(
                    hint: 'Duration',
                    keybordType: TextInputType.number,
                    width: MediaQuery.of(context).size.width * 0.5,
                    controller: duration),
                Spacer(),
                DropdownButton<String>(
                  value: unit,
                  onChanged: (String? value) => {
                    setState(() {
                      unit = value!;
                    })
                  },
                  items: Unit.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        // style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
                Spacer()
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: ElevatedButton(
                onPressed: () async {
                  await uploadImage();
                  await uploadEvent();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: const Text(
                  'Create Event',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
