import 'package:flutter/material.dart';

class MyPageRouter extends PageRouteBuilder {
  final Widget page;
  final Offset begin;
  final int duration;

  MyPageRouter({
    required this.page,
    required this.begin,
    required this.duration,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: Duration(milliseconds: duration),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: begin,
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
