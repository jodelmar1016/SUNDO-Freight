import 'package:flutter/material.dart';
import 'package:freight/wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eCarga',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Wrapper(),
    );
  }
}
