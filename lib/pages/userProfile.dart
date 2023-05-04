import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    Widget contactus = TextFormField(
      readOnly: true,
      decoration: InputDecoration(
          icon: Icon(
            Icons.comment,
          ),
          hintText: "Contact Us",
          border: UnderlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.chevron_right,
            ),
          )),
    );
    Widget faq = TextFormField(
      readOnly: true,
      decoration: InputDecoration(
          icon: Icon(
            Icons.question_mark_rounded,
          ),
          hintText: "FAQ",
          border: UnderlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.chevron_right,
            ),
          )),
    );
    Widget terms = TextFormField(
      readOnly: true,
      decoration: InputDecoration(
          icon: Icon(
            Icons.file_copy,
          ),
          hintText: "Terms and Conditions",
          border: UnderlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.chevron_right,
            ),
          )),
    );
    Widget privacy = TextFormField(
      readOnly: true,
      decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
          ),
          hintText: "Privacy and Policy",
          border: UnderlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.chevron_right,
            ),
          )),
    );
    Widget logout = TextFormField(
      readOnly: true,
      decoration: InputDecoration(
          icon: Icon(
            Icons.logout,
          ),
          hintText: "Logout",
          border: UnderlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.chevron_right,
            ),
          )),
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
                image: AssetImage('images/logo-text.png'), color: Colors.teal),
            SizedBox(height: 50),
            Icon(
              Icons.face,
              size: 100,
            ),
            Text(
              'Juan Dela Cruz',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'jdcruz@gmail.com',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 100),
            contactus,
            faq,
            terms,
            privacy,
            logout,
          ],
        ),
      ),
    );
  }
}
