import 'package:chatbot/chat.bot.dart';
import 'package:chatbot/login.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        indicatorColor: Colors.white,
      ),
      routes: {
        "/chat": (context) => ChatBot(),
      },
      home: LoginPage(),
    );
  }
}
