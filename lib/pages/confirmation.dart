import 'package:flutter/material.dart';
import 'package:freight/models/bookings.dart';
import 'package:freight/pages/wrapper.dart';
import 'package:freight/services/dataService.dart';

class Confirmation extends StatefulWidget {
  Booking data;
  Confirmation({super.key, required this.data});

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Origin: ${widget.data.originName}'),
                            Text('Destination: ${widget.data.destinationName}'),
                            Divider(),
                            Text('Type of Cargo: ${widget.data.type_of_cargo}'),
                            Text('Weight: ${widget.data.weight}kg'),
                            Text('Length: ${widget.data.length}ft'),
                            Text('Width: ${widget.data.width}ft'),
                            Text('Height: ${widget.data.height}ft'),
                            Divider(),
                            Text('Sender name: ${widget.data.senderName}'),
                            Text(
                                'Sender contact: ${widget.data.senderContactNo}'),
                            Text('Receiver name: ${widget.data.receiverName}'),
                            Text(
                                'Receiver contact: ${widget.data.receiverContactNo}'),
                            Divider(),
                            Text(
                                'Payment method: ${widget.data.paymentMethod}'),
                            Text('Total amount: ${widget.data.costWithFee}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      // ADD BOOKING
                      await DataService.addBooking(widget.data);
                      setState(() {
                        _isLoading = false;
                      });
                      // NAVIGATE TO HOME
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (contex) => Wrapper()),
                        (route) => false,
                      );
                    },
                    child: Text('SUBMIT'),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
