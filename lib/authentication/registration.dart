import 'package:flutter/material.dart';
import 'package:freight/services/auth.dart';
import 'package:freight/models/response.dart';
import 'package:freight/authentication/login.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool passwordObscured = true;
  bool confirmPasswordObscured = true;
  bool _isLoading = false;

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _contactNumber = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _contactNumber.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // USERNAME
    // Widget username = TextFormField(
    //   decoration: InputDecoration(
    //     hintText: "Username",
    //     labelText: "Username",
    //     border: OutlineInputBorder(),
    //   ),
    // );

    // BIRTHDAY
    // Widget birthday = TextFormField(
    //   decoration: InputDecoration(
    //     hintText: "Birthday",
    //     labelText: "Birthday",
    //     border: OutlineInputBorder(),
    //   ),
    // );

    // FIRST NAME
    Widget firstName = TextFormField(
      controller: _firstName,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      decoration: InputDecoration(
        labelText: "First Name",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person),
      ),
    );

    // LAST NAME
    Widget lastName = TextFormField(
      controller: _lastName,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person),
      ),
    );

    // CONTACT NUMBER
    Widget contactnumber = TextFormField(
      controller: _contactNumber,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
      },
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: "Contact Number",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.phone),
      ),
    );

    // EMAIL
    Widget email = TextFormField(
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
        labelText: "Email Address",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
      ),
    );

    // PASSWORD
    Widget password = TextFormField(
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

    // CONFIRM PASSWORD
    Widget confirmPassword = TextFormField(
      controller: _confirmPassword,
      obscureText: confirmPasswordObscured,
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
        labelText: "Confirm Password",
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              confirmPasswordObscured = !confirmPasswordObscured;
            });
          },
          icon: Icon(
            confirmPasswordObscured ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
    );

    // SIGN UP BUTTON
    Widget signup = ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          setState(() {
            _isLoading = true;
          });
          Response response = await _auth.registerEmailPassword(
              _firstName.text.trim(),
              _lastName.text.trim(),
              _email.text.trim(),
              _password.text.trim());
          setState(() {
            _isLoading = false;
          });
          if (response.code == 500) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(response.message.toString()),
                );
              },
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Account Created, you can now Login')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          }
        }
      },
      child: Text('SIGN UP'),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 50),
                    child: Column(
                      children: [
                        Image(
                            image: AssetImage('assets/logo-text.png'),
                            color: Colors.teal),
                        SizedBox(height: 50),
                        Text(
                          'Sign Up Your Account',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        firstName,
                        SizedBox(height: 30),
                        lastName,
                        SizedBox(height: 30),
                        email,
                        SizedBox(height: 30),
                        password,
                        SizedBox(height: 30),
                        confirmPassword,
                        SizedBox(height: 30),
                        signup,
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                              child: Text('LOG IN'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.grey[200],
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.teal),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
