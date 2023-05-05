import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freight/pages/home.dart';
import 'package:freight/pages/notification.dart';
import 'package:freight/pages/profile.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _currentIndex = 0;
  List<Widget> _body = [Home(), NotificationPage(), Profile()];
  List<Widget> _appBarTitle = [
    Image.asset(
      'assets/logo-text.png',
      color: Colors.teal,
      width: 180,
    ),
    Text('N O T I F I C A T I O N'),
    Text('P R O F I L E')
  ];
  List<bool> _centerTitle = [false, true, true];
  // List<String> _appBarTitle = ['', 'NOTIFICATION', 'PROFILE'];
  List<Color> _colors = [Colors.transparent, Colors.teal, Colors.teal];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: _appBarTitle[_currentIndex],
        centerTitle: _centerTitle[_currentIndex],
        elevation: 0,
        backgroundColor: _colors[_currentIndex],
      ),
      body: _body[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}