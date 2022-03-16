import 'package:flutter/material.dart';
import 'sos_screen.dart';
//import 'try.dart';
import 'camera_page.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'home page',
      debugShowCheckedModeBanner: false,
      home:camera_page(),
    );
  }
}