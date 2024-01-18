import 'package:flutter/material.dart';
import 'package:youngmind/screens/services/email_services.dart';
import 'package:youngmind/widgets/text_input.dart';

class EmailScreen extends StatefulWidget {
  final dynamic emails;
  const EmailScreen({super.key, required this.emails});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  TextEditingController subject = TextEditingController();
  TextEditingController body = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Email'),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              "Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
            ),
            TextInput(hint: 'Subject', controller: subject),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            TextInput(hint: "Body of the main", maxlines: 15, controller: body),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                print(widget.emails);
                List<String> email = [];
                for (var element in widget.emails) {
                  email.add(element.toString());
                }
                print('sending email');
                EmailServices().send(email, body.text, subject.text);
              },
              child: const Text("Send email"),
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
