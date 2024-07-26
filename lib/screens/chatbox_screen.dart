import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatboxScreen extends StatelessWidget {
  static const routName = "/ChatboxScreen";
  final String chatUrl = 'https://chat.openai.com/';

  Future<void> _launchURL() async {
    if (!await launch(chatUrl)) {
      throw 'Could not launch $chatUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbox'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _launchURL,
          child: Text('Open ChatGPT'),
        ),
      ),
    );
  }
}
