import 'package:flutter/material.dart';

class BookingItem extends StatelessWidget {
  final String title;
  const BookingItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(title),
        leading: Icon(Icons.location_pin),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
