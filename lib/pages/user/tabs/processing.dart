import 'package:flutter/material.dart';
import 'package:freight/components/bookingItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freight/services/dataService.dart';

class Processing extends StatefulWidget {
  const Processing({super.key});

  @override
  State<Processing> createState() => _ProcessingState();
}

class _ProcessingState extends State<Processing> {
  final Stream<QuerySnapshot> collectionReference = DataService.readBookings();
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
                return BookingItem(
                  title: snapshot.data!.docs[index]['origin'],
                );
              },
            );
          }
        }
        return Container();
      },
    );
  }
}
