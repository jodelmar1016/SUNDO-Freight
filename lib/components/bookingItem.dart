import 'package:flutter/material.dart';
import 'package:freight/functions/gmap.dart';
import 'package:freight/pages/details.dart';
import 'package:freight/pages/tracking.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:freight/models/bookings.dart';

class BookingItem extends StatelessWidget {
  final Booking data;
  const BookingItem({
    super.key,
    required this.data,
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
              builder: (contect) => Details(data: data),
            ),
          );
        },
        title: Text('${data.type_of_cargo}'),
        // title: Text('Tracking No.: $trackingNumber'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('Sender: $sender'),
            // Text('Receiver: $receiver'),
            Text('Origin: ${data.originName}'),
            Text('Destination: ${data.destinationName}'),
            Divider(color: Colors.teal),
            Text(
              'Total Cost: ${data.totalCost}',
              style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
