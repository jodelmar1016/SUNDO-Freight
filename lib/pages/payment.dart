import 'package:flutter/material.dart';
import 'package:freight/models/bookings.dart';
import 'package:freight/pages/confirmation.dart';

class Payment extends StatefulWidget {
  Booking data;
  Payment({super.key, required this.data});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String selectedPaymentMethod = '';

  addPaymentMethod() {
    if (selectedPaymentMethod != '') {
      widget.data.paymentMethod = selectedPaymentMethod;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Confirmation(data: widget.data),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Please select payment method'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    'Select a payment method',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  ListTile(
                    enabled: false,
                    onTap: () {
                      setState(() {
                        selectedPaymentMethod = 'GCash';
                      });
                    },
                    leading: Image.asset(
                      'assets/gcash.png',
                      width: 50,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('GCash'),
                        Text(
                          'Unavailable',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ],
                    ),
                    trailing: Radio(
                      value: 'GCash',
                      groupValue: selectedPaymentMethod,
                      onChanged: null,
                    ),
                  ),
                  ListTile(
                    enabled: false,
                    onTap: () {
                      setState(() {
                        selectedPaymentMethod = 'PayMaya';
                      });
                    },
                    leading: Image.asset(
                      'assets/paymaya.png',
                      width: 50,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('PayMaya'),
                        Text(
                          'Unavailable',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ],
                    ),
                    trailing: Radio(
                      value: 'PayMaya',
                      groupValue: selectedPaymentMethod,
                      onChanged: null,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        selectedPaymentMethod = 'Cash';
                      });
                    },
                    leading: Image.asset(
                      'assets/cash.png',
                      color: Colors.teal,
                      width: 50,
                    ),
                    title: Text('Cash'),
                    trailing: Radio(
                      value: 'Cash',
                      groupValue: selectedPaymentMethod,
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentMethod = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  addPaymentMethod();
                },
                child: Text('NEXT'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
