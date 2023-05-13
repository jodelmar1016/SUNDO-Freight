import 'package:flutter/material.dart';
import 'package:freight/models/bookings.dart';
import 'package:freight/pages/myBookings.dart';
import 'package:freight/services/dataService.dart';

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
    print(data.display());
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${data.originName}'),
          if (data.status == 'processing')
            ElevatedButton(
                onPressed: () async {
                  cancelBookingConfirmation(context);
                  // Navigator.pop(context);
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text('An error occurred')),
                  // );
                },
                child: Text('Cancel Booking'))
          else if (data.status == 'in transit')
            ElevatedButton(onPressed: () {}, child: Text('Track'))
        ],
      ),
    );
  }
}
