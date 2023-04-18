import 'dart:math';

String generateTrackingNumber() {
  final DateTime now = DateTime.now();
  final int millisecondsSinceEpoch = now.millisecondsSinceEpoch;
  final int random = Random().nextInt(9000) + 1000;
  final String trackingNumber = '$millisecondsSinceEpoch$random';

  return trackingNumber;
}
