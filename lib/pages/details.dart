import 'package:flutter/material.dart';
import 'package:freight/models/bookings.dart';
import 'package:freight/pages/myBookings.dart';
import 'package:freight/services/dataService.dart';
import 'package:badges/badges.dart' as badges;

class Details extends StatelessWidget {
  final Booking data;
  const Details({
    super.key,
    required this.data,
  });

  // CANCEL BOOKING FUNCTION
  Future<void> cancelBooking(context) async {
    if (await DataService.calcelBooking(data.docId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking Cancelled')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred')),
      );
      Navigator.pop(context);
    }
  }

  // CANCEL BOOKING CONFIRMATION
  void cancelBookingConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Booking'),
          content: Text('Are you sure you want to cancel your booking'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    ).then((value) {
      if (value == true) {
        cancelBooking(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data.status == 'in transit')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tracking No: ${data.trackingNo}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.copy, size: 20))
                        ],
                      ),
                    Text('Origin: ${data.originName}'),
                    Text('Destination: ${data.destinationName}'),
                    Divider(color: Colors.teal),
                    Text(
                      'Cargo Information',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Type of Cargo: ${data.type_of_cargo}'),
                    Text('Weight: ${data.weight}kg'),
                    Text('Length: ${data.length}'),
                    Text('Width: ${data.width}'),
                    Text('Height: ${data.height}'),
                    Divider(color: Colors.teal),
                    Text(
                      'Sender Information',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Name: ${data.senderName}'),
                    Text('Contact: ${data.senderContactNo}'),
                    Divider(color: Colors.teal),
                    Text(
                      'Receiver Information',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('Name: ${data.receiverName}'),
                    Text('Contact: ${data.receiverContactNo}'),
                    Divider(color: Colors.teal),
                    Text(
                      'Cost',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'Booking fee: ${(data.fee! * 100).toStringAsFixed(0)}%'),
                    Text('Payment Method: ${data.paymentMethod}'),
                    Text('Total Cost: ${(data.totalCost)!.toStringAsFixed(2)}'),
                    badges.Badge(
                      badgeContent:
                          Text('3', style: TextStyle(color: Colors.white)),
                      child: Icon(Icons.notifications),
                    )
                  ],
                ),
              ),
            ),
            if (data.status == 'processing')
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      cancelBookingConfirmation(context);
                    },
                    child: Text('Cancel Booking')),
              )
            else if (data.status == 'in transit')
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(onPressed: () {}, child: Text('Track')),
              )
          ],
        ),
      ),
    );
  }
}
