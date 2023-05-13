import 'package:flutter/material.dart';
import 'package:freight/components/bookingItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freight/services/dataService.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:freight/functions/gmap.dart';
import 'package:freight/models/bookings.dart';

class Processing extends StatefulWidget {
  const Processing({super.key});

  @override
  State<Processing> createState() => _ProcessingState();
}

class _ProcessingState extends State<Processing> {
  final Stream<QuerySnapshot> collectionReference =
      DataService.getProcessingAndForPickUp();
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
