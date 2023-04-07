import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freight/models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('bookings');

class DataService {
  static Response addBookings() {
    Response response = Response();
    response.code = 500;
    response.message = 'FAILED';
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
