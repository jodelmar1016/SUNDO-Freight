import 'package:flutter/material.dart';
import 'package:freight/models/response.dart';
import 'package:freight/pages/wrapper.dart';
import 'package:freight/router.dart';
import 'dart:async';
import 'package:freight/services/auth.dart';
import 'package:freight/authentication/registration.dart';
import 'package:freight/components/loadingWithOpacity.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordObscured = true;
  bool _isLoading = false;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // EMAIL
    final email = TextFormField(
      controller: _email,
      validator: (value) {
        if (value != null) {
          if (value.contains('@') && value.endsWith('.com')) {
            return null;
          }
          return 'Enter a Valid Email Address';
        }
      },
      decoration: InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
    );
    // PASSWORD
    final password = TextFormField(
      controller: _password,
      obscureText: passwordObscured,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        if (value.trim().length < 8) {
          return 'Password must be at least 8 characters in length';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              passwordObscured = !passwordObscured;
            });
          },
          icon: Icon(
            passwordObscured ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
    );
    // LOGIN GUEST BUTTON
    final guest = ElevatedButton(
      onPressed: () async {
        // dynamic result = await _auth.signInAnonymous();

        // if (result.uid == null) {
        //   showDialog(
        //       context: context,
        //       builder: (context) {
        //         return AlertDialog(
        //           content: Text(result.code),
        //         );
        //       });
        // }
      },
      child: Text('GUEST'),
    );
    // LOGIN BUTTON
    final loginButton = ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          setState(() {
            _isLoading = true;
          });
          Response result = await _auth.signInEmailPassword(
              _email.text.trim(), _password.text.trim());
          setState(() {
            _isLoading = false;
          });
          if (result.code == 500) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(result.message.toString()),
                );
              },
            );
          } else {
            Navigator.pushReplacement(
              context,
              MyPageRouter(
                page: Wrapper(),
                begin: Offset(0.0, 1.0),
                duration: 300,
              ),
            );
          }
        }
      },
      child: Text('LOG IN'),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      image: AssetImage('assets/logo-text.png'),
                      color: Colors.teal),
                  SizedBox(height: 70),
                  email,
                  SizedBox(height: 30),
                  password,
                  SizedBox(height: 30),
                  loginButton,
                  // SizedBox(height: 30),
                  // guest,
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Does not have an account yet?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Registration(),
                            ),
                          );
                        },
                        child: Text('SIGN UP'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading) LoadingWithOpacity()
        ],
      ),
    );
  }
}
