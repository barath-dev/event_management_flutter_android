import 'package:flutter_email_sender/flutter_email_sender.dart';
  
class EmailServices {
  Future<void> send() async {
    final Email email = Email(
      body: 'this is a test email',
      subject: 'Hello',
      recipients: ['barathwajk@proton.me'],
      cc: ['barathwaj77777@gmail.com','barathwaj1153@gmail.com'],
      // bcc: ['bcc@example.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }
}
