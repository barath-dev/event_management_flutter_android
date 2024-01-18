import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youngmind/widgets/text_input.dart';

class SendNotification extends StatefulWidget {
  final dynamic requests;
  const SendNotification({super.key, required this.requests});

  @override
  State<SendNotification> createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Notification"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              "Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            ),
            TextInput(hint: 'Title', controller: title),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            TextInput(
                hint: "description", maxlines: 5, controller: description),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                for (var element in widget.requests) {
                  await FirebaseFirestore.instance
                      .collection('notifications')
                      .doc(element)
                      .update({
                    'notifications': FieldValue.arrayUnion([
                      {
                        'title': title.text,
                        'description': description.text,
                      }
                    ])
                  });
                }
              },
              child: const Text("Send Notification"),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
