import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freight/models/response.dart';
import 'package:freight/models/bookings.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('bookings');

class DataService {
  // ADD BOOKING
  static Future<Response> addBooking(Booking newBooking) async {
    Response response = new Response();
    DocumentReference documentReferencer = _collection.doc();

    Map<String, dynamic> data = newBooking.convertToMap();

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
