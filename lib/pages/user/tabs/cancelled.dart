import 'package:flutter/material.dart';
import 'package:freight/components/bookingItem.dart';

class Cancelled extends StatelessWidget {
  const Cancelled({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          BookingItem(
            title: 'Item 1',
            subtitle: 'item 1',
          ),
        ],
      ),
    );
  }
}
