import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freight/models/response.dart';
import 'package:freight/models/bookings.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('bookings');

class DataService {
  static String userId = '';
  static String userName = '';
  static String userEmail = '';

  // GET USER INFO
  static Future<void> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId')!;
    userName = prefs.getString('userName')!;
    userEmail = prefs.getString('userEmail')!;
  }

  // ADD BOOKING
  static Future<Response> addBooking(Booking newBooking) async {
    Response response = new Response();
    DocumentReference documentReferencer = _collection.doc();

    // ADD USER ID
    newBooking.userId = userId;
    Map<String, dynamic> data = newBooking.convertToMap();
    data['date'] = FieldValue.serverTimestamp();

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = 'Sucessfully added to the database';
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readBookings(status) {
    CollectionReference bookingItemCollection = _collection;
    bookingItemCollection.get();

    Query query = bookingItemCollection.where('status', isEqualTo: status);
    return query.snapshots();
  }

  static Stream<QuerySnapshot> getProcessingAndForPickUp() {
    CollectionReference bookingItemCollection = _collection;
    bookingItemCollection.get();

    Query query = bookingItemCollection
        .where('status', whereIn: ['processing', 'for pick up']);
    return query.snapshots();
  }

  static Future<bool> calcelBooking(docId) async {
    try {
      _collection.doc(docId).update({
        'status': 'cancelled',
        'waiting': false,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Booking mapData(DocumentSnapshot snapshot) {
    Booking data = new Booking();

    // CONVERT GEOPOINT TO LATLNG
    GeoPoint geoOrigin = snapshot['origin'];
    LatLng origin = LatLng(geoOrigin.latitude, geoOrigin.longitude);
    GeoPoint geoDestination = snapshot['destination'];
    LatLng destination =
        LatLng(geoDestination.latitude, geoDestination.longitude);

    // ADD DATA
    data.docId = snapshot.id;
    data.origin = origin;
    data.destination = destination;
    data.originName = snapshot['origin_name'];
    data.destinationName = snapshot['destination_name'];
    data.type_of_cargo = snapshot['type_of_cargo'];
    data.type_of_vehicle = snapshot['type_of_vehicle'];
    data.weight = snapshot['weight'];
    data.length = snapshot['length'];
    data.width = snapshot['width'];
    data.height = snapshot['height'];
    data.distance = snapshot['distance'];
    data.senderName = snapshot['sender_name'];
    data.senderContactNo = snapshot['sender_contact_no'];
    data.receiverName = snapshot['receiver_name'];
    data.receiverContactNo = snapshot['receiver_contact_no'];
    data.totalCost = snapshot['cost'];
    data.fee = snapshot['fee'];
    data.driversShare = snapshot['driver_share'];
    data.paymentMethod = snapshot['payment_method'];
    data.status = snapshot['status'];
    data.trackingNo = snapshot['tracking_number'];
    data.userId = snapshot['userId'];
    data.date = snapshot['date'].toDate();

    data.display();

    return data;
  }

  static Stream<QuerySnapshot> getNotification() {
    CollectionReference _notification =
        _firestore.collection('users/${userId}/notification');

    Query notificationCollection =
        _notification.orderBy('timestamp', descending: true);

    return notificationCollection.snapshots();
  }

  static Future<bool> markAsReadNotification(docId) async {
    CollectionReference _notification =
        _firestore.collection('users/${userId}/notification');

    DocumentReference documentRef = _notification.doc(docId);

    try {
      await documentRef.update({'unread': false});
      return true;
    } catch (e) {
      print('Error updating document: $e');
      return false;
    }
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
