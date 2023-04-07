import 'package:flutter/material.dart';
import 'package:freight/splash.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  print('Connected to firebase');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eCarga',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const Splash(),
    );
  }
}
