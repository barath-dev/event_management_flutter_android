import 'package:flutter_email_sender/flutter_email_sender.dart';
  
class EmailServices {
  Future<void> send(List<String> cc) async {
    final Email email = Email(
      body: 'this is a test email',
      subject: 'Hello',
      recipients: ['barathwaj77777@gmail.com'],
      cc: cc,
      // bcc: ['bcc@example.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }
}
