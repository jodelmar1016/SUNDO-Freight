import 'dart:math';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String generateTrackingNumber() {
  final DateTime now = DateTime.now();
  final int millisecondsSinceEpoch = now.millisecondsSinceEpoch;
  final int random = Random().nextInt(9000) + 1000;
  final String trackingNumber = '$millisecondsSinceEpoch$random';

  return trackingNumber;
}

String formatToDate(timestamp) {
  final DateFormat formatter = DateFormat('MM-dd-yyyy');
  return formatter.format(timestamp.toDate());
}

int validatePassword(password) {
  RegExp capital = RegExp(r'^(?=.*?[A-Z])');
  RegExp small = RegExp(r'^(?=.*?[a-z])');
  RegExp special = RegExp(r'^(?=.*?[!@#\$&*~])');
  RegExp numbers = RegExp(r'^(?=.*?[0-9])');

  if (!capital.hasMatch(password)) {
    return 1;
  }
  if (!small.hasMatch(password)) {
    return 2;
  }
  if (!special.hasMatch(password)) {
    return 3;
  }
  if (!numbers.hasMatch(password)) {
    return 4;
  }
  return 0;
}
 // RegExp regex =
  //     RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  // return regex.hasMatch(password);