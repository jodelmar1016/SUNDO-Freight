import 'package:flutter/material.dart';
import 'package:freight/components/bookingItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freight/services/dataService.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:freight/functions/gmap.dart';
import 'package:freight/models/bookings.dart';

class InTransit extends StatefulWidget {
  const InTransit({super.key});

  @override
  State<InTransit> createState() => _InTransitState();
}

class _InTransitState extends State<InTransit> {
  final Stream<QuerySnapshot> collectionReference =
      DataService.readBookings('in transit');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: collectionReference,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                Booking data = DataService.mapData(snapshot.data!.docs[index]);

                return BookingItem(data: data);
              },
            );
          }
        }
        return Container();
      },
    );
  }
}
