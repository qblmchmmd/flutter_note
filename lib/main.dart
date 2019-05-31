import 'package:flutter/material.dart';
import 'package:flutter_note/di.dart';
import 'package:flutter_note/screens/homescreen.dart';
import 'package:dartin/dartin.dart';

void main() async {
  startDartIn(appModule);
  runApp(FlutterNoteApp());
}

class FlutterNoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Note',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}
