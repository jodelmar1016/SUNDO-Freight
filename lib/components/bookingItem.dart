import 'package:flutter/material.dart';
import 'package:freight/functions/gmap.dart';
import 'package:freight/pages/tracking.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookingItem extends StatelessWidget {
  final String trackingNumber;
  final String origin;
  final String destination;
  final LatLng originLatLng;
  final LatLng destinationLatLng;
  final double totalCost;
  const BookingItem({
    super.key,
    required this.trackingNumber,
    required this.origin,
    required this.originLatLng,
    required this.destination,
    required this.destinationLatLng,
    required this.totalCost,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contect) =>
                  Tracking(points: [originLatLng, destinationLatLng]),
            ),
          );
        },
        title: Text('Tracking No.: $trackingNumber'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('Sender: $sender'),
            // Text('Receiver: $receiver'),
            Text('Origin: $origin'),
            Text('Destination: $destination'),
            Divider(color: Colors.teal),
            Text(
              'Total Cost: $totalCost',
              style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
