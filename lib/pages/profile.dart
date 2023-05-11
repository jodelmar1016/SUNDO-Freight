import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freight/authentication/login.dart';
import 'package:freight/router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String uid = '';

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString('userId')!;
      print('uid:' + uid);
    });
  }

  Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(uid.isNotEmpty ? uid : 'Loading...'),
        ElevatedButton(
          onPressed: () async {
            await clearPrefs();
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => Login(),
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder: (context, animation1, animation2, child) {
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
          child: Text('Logout'),
        )
      ],
    );
  }
}
