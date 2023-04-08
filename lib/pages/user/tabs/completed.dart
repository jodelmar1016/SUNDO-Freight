import 'package:flutter/material.dart';
import 'package:freight/components/bookingItem.dart';

class Completed extends StatelessWidget {
  const Completed({super.key});

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
          BookingItem(
            title: 'Item 2',
            subtitle: 'item 2',
          ),
          BookingItem(
            title: 'Item 3',
            subtitle: 'item 3',
          ),
        ],
      ),
    );
  }
}
