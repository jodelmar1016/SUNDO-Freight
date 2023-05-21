import 'package:flutter/material.dart';
import 'package:freight/router.dart';
import 'package:freight/services/dataService.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:freight/authentication/login.dart';
import 'package:freight/pages/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    checkAuthState();
  }

  Future<String?> getUID(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> checkAuthState() async {
    final res = await getUID('userId');
    if (res != null) {
      // GET USER INFO
      await DataService.getUserInfo();
      await Future.delayed(
        Duration(milliseconds: 1500),
        () {
          Navigator.pushReplacement(context, _createRoute(Wrapper()));
        },
      );
    } else {
      await Future.delayed(
        Duration(milliseconds: 1500),
        () {
          Navigator.pushReplacement(context, _createRoute(Login()));
        },
      );
    }
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration(milliseconds: 1000),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.1, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Image.asset(
          'assets/splash.gif',
          fit: BoxFit.fill,
          width: 300,
          color: Colors.white,
        ),
      ),
    );
  }
}
