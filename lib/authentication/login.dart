import 'package:flutter/material.dart';
import 'package:freight/pages/user/wrapper.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool passwordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                image: AssetImage('assets/logo-text.png'), color: Colors.teal),
            SizedBox(height: 70),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Email",
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              obscureText: passwordObscured,
              decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        passwordObscured = !passwordObscured;
                      });
                    },
                    icon: Icon(
                      passwordObscured
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  )),
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Wrapper(),
                    ),
                  );
                },
                child: Text('LOG IN')),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Does not have an account yet?'),
                TextButton(onPressed: () {}, child: Text('SIGN UP')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
