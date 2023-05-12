import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Booking {
  String? docId;
  LatLng? origin;
  LatLng? destination;
  String? originName;
  String? destinationName;
  String? type_of_cargo;
  String? type_of_vehicle;
  double? weight;
  double? length;
  double? width;
  double? height;
  double? distance;
  double? cost;
  double? costWithFee;
  String? senderName;
  String? senderContactNo;
  String? receiverName;
  String? receiverContactNo;
  String? paymentMethod;
  String? driverId;
  String? status;
  bool waiting = true;
  String? trackingNo;

  Booking({
    this.origin,
    this.destination,
    this.originName,
    this.destinationName,
    this.type_of_cargo,
    this.type_of_vehicle,
    this.weight,
    this.length,
    this.width,
    this.height,
    this.distance,
    this.cost,
    this.costWithFee,
    this.senderName,
    this.senderContactNo,
    this.receiverName,
    this.receiverContactNo,
    this.paymentMethod,
    this.status,
  });

  display() {
    print('origin: $origin');
    print('origin name: $originName');
    print('destination: $destination');
    print('destination Name: $destinationName');
    print('type of cargo: $type_of_cargo');
    print('type of vehicle: $type_of_vehicle');
    print('weight: $weight');
    print('length: $length');
    print('width: $width');
    print('height: $height');
    print('distance: $distance');
    print('cost: $cost');
    print('cost with fee: $costWithFee');
    print('sender name: $senderName');
    print('sender contact: $senderContactNo');
    print('receiver name: $receiverName');
    print('receiver contact: $receiverContactNo');
    print('payment method: $paymentMethod');
  }

  Map<String, dynamic> convertToMap() {
    return {
      'origin': GeoPoint(origin!.latitude, origin!.longitude),
      'destination': GeoPoint(destination!.latitude, destination!.longitude),
      'origin_name': originName,
      'destination_name': destinationName,
      'type_of_cargo': type_of_cargo,
      'type_of_vehicle': type_of_vehicle,
      'weight': weight,
      'length': length,
      'width': width,
      'height': weight,
      'distance': distance,
      'cost': cost,
      'cost_with_fee': costWithFee,
      'sender_name': senderName,
      'sender_contact_no': senderContactNo,
      'receiver_name': receiverName,
      'receiver_contact_no': receiverContactNo,
      'payment_method': paymentMethod,
      'waiting': waiting,
      'status': status,
    };
  }
}
