import 'package:flutter_email_sender/flutter_email_sender.dart';
  
class EmailServices {
  Future<void> send(List<String> cc,String body,String subject) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: ['barathwaj77777@gmail.com'],
      cc: cc,
      // bcc: ['bcc@example.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }
}
