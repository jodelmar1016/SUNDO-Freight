import 'package:google_maps_flutter/google_maps_flutter.dart';

class Booking {
  LatLng origin;
  LatLng destination;
  String originName;
  String destinationName;
  String type_of_cargo;
  double weight;
  double length;
  double width;
  double height;
  double cost;
  String senderName;
  String senderContactNo;
  String receiverName;
  String receiverContactNo;

  Booking({
    required this.origin,
    required this.destination,
    required this.originName,
    required this.destinationName,
    required this.type_of_cargo,
    required this.weight,
    required this.length,
    required this.width,
    required this.height,
    required this.cost,
    required this.senderName,
    required this.senderContactNo,
    required this.receiverName,
    required this.receiverContactNo,
  });

  Map<String, dynamic> toMap() {
    return {
      'origin': origin,
      'destination': destination,
      'type_of_cargo': type_of_cargo,
      'weight': weight,
      'length': length,
      'width': width,
      'height': height,
      'cost': cost,
      'sender_name': senderName,
      'sender_contact_no': senderContactNo,
      'receiver_name': receiverName,
      'receiver_contact_no': receiverContactNo,
    };
  }
}
