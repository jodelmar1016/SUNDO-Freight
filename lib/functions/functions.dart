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
