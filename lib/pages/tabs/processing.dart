import 'package:flutter/material.dart';
import 'package:freight/components/bookingItem.dart';

class Processing extends StatelessWidget {
  const Processing({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          BookingItem(
            title: 'Item 1',
          ),
          BookingItem(
            title: 'Item 2',
          ),
        ],
      ),
    );
  }
}
