import 'package:flutter/material.dart';
import 'package:freight/pages/user/wrapper.dart';
import 'package:freight/pages/admin/dashboard.dart';
import 'package:freight/router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:freight/authentication/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(
      Duration(milliseconds: 1500),
      () {
        Navigator.pushReplacement(context, MyPageRouter(page: Login()));
      },
    );
  }

  // Route _createRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => Wrapper(),
  //     transitionDuration: Duration(milliseconds: 1000),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(0.1, 1.0);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;

  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Image.asset(
          'assets/logo-text.png',
          fit: BoxFit.fill,
          width: 300,
          color: Colors.white,
        ),
      ),
    );
  }
}
