import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freight/models/response.dart';
import 'package:freight/models/bookings.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('bookings');

class DataService {
  // static Response addBookings() {
  //   Response response = Response();
  //   response.code = 500;
  //   response.message = 'FAILED';
  //   return response;
  // }

  // static test(Booking newBooking) {
  //   print(newBooking.origin);
  //   print(newBooking.destination);
  //   print(newBooking.type_of_cargo);
  //   print(newBooking.weight);
  //   print(newBooking.length);
  //   print(newBooking.width);
  //   print(newBooking.height);
  //   print(newBooking.cost);
  //   print(newBooking.senderName);
  //   print(newBooking.senderContactNo);
  //   print(newBooking.receiverName);
  //   print(newBooking.receiverContactNo);
  // }

  static Future<Response> addBooking(Booking newBooking) async {
    // CONVERT THE LATLNG TO GEOPOINT
    GeoPoint origin = GeoPoint(
      newBooking.origin.latitude,
      newBooking.origin.longitude,
    );
    GeoPoint destination = GeoPoint(
      newBooking.destination.latitude,
      newBooking.destination.longitude,
    );

    Response response = new Response();
    DocumentReference documentReferencer = _collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      'origin': origin,
      'destination': destination,
      'origin_name': newBooking.originName,
      'destination_name': newBooking.destinationName,
      'type_of_cargo': newBooking.type_of_cargo,
      'type_of_vehicle': newBooking.type_of_vehicle,
      'weight': newBooking.weight,
      'length': newBooking.length,
      'width': newBooking.width,
      'height': newBooking.height,
      'cost': newBooking.cost,
      'cost_with_fee': newBooking.costWithFee,
      'sender_name': newBooking.senderName,
      'sender_contact_no': newBooking.senderContactNo,
      'receiver_name': newBooking.receiverName,
      'receiver_contact_no': newBooking.receiverContactNo,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = 'Sucessfully added to the database';
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readBookings() {
    CollectionReference bookingItemCollection = _collection;

    bookingItemCollection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot doc) {
        print(doc.data());
      });
    });

    return bookingItemCollection.snapshots();
  }
  // For future purposes
  // static printDocument() async {
  //   CollectionReference bookingItemCollection = _collection;
  //   print('testing');
  //   await bookingItemCollection.get().then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((DocumentSnapshot doc) {
  //       print(doc.data());
  //     });
  //   });
  // }
}
