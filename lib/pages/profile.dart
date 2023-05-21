import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freight/authentication/login.dart';
import 'package:freight/router.dart';
import 'package:freight/services/dataService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = DataService.userName;
  String email = DataService.userEmail;

  Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  foregroundColor: Colors.black,
                  radius: 50,
                  child: Icon(
                    Icons.face,
                    size: 80,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$name',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      '$email',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Divider(
            color: Colors.teal,
            thickness: 2,
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 50),
                Items(
                  title: 'Contact Us',
                  icon: Icon(
                    Icons.comment,
                  ),
                  action: () {},
                ),
                Items(
                  title: 'FAQ',
                  icon: Icon(
                    Icons.question_mark_rounded,
                  ),
                  action: () {},
                ),
                Items(
                  title: 'Terms and Conditions',
                  icon: Icon(
                    Icons.file_copy,
                  ),
                  action: () {},
                ),
                Items(
                  title: 'Privacy Policy',
                  icon: Icon(
                    Icons.lock,
                  ),
                  action: () {},
                ),
                Items(
                  title: 'Logout',
                  icon: Icon(
                    Icons.logout,
                  ),
                  action: () async {
                    await clearPrefs();
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            Login(),
                        transitionDuration: Duration(milliseconds: 500),
                        transitionsBuilder:
                            (context, animation1, animation2, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset(-1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation1),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Items extends StatelessWidget {
  final String title;
  final Icon icon;
  final VoidCallback action;
  const Items({
    super.key,
    required this.title,
    required this.icon,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: action,
      leading: icon,
      title: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$title',
                style: TextStyle(fontSize: 14),
              ),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
      horizontalTitleGap: 3,
    );
  }
}
