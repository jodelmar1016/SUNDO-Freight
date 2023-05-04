import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    Widget username = TextFormField(
      decoration: InputDecoration(
        hintText: "Username",
        labelText: "Username",
        border: OutlineInputBorder(),
      ),
    );
    Widget birthday = TextFormField(
      decoration: InputDecoration(
        hintText: "Birthday",
        labelText: "Birthday",
        border: OutlineInputBorder(),
      ),
    );
    Widget contactnumber = TextFormField(
      decoration: InputDecoration(
        hintText: "Contact Number",
        labelText: "Contact Number",
        border: OutlineInputBorder(),
      ),
    );
    Widget email = TextFormField(
      decoration: InputDecoration(
        hintText: "Email Address",
        labelText: "Email Address",
        border: OutlineInputBorder(),
      ),
    );
    Widget password = TextFormField(
      decoration: InputDecoration(
        hintText: "Password",
        labelText: "Password",
        border: OutlineInputBorder(),
      ),
    );

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(image: AssetImage('images/logo-text.png'), color: Colors.teal),
          Text(
            'Sign Up Your Account',
            style: TextStyle(fontSize: 20),
          ),
          username,
          birthday,
          contactnumber,
          email,
          password,
          ElevatedButton(onPressed: () {}, child: Text('SIGN UP')),
        ],
      ),
    ));
  }
}
