import 'package:flutter/material.dart';

class BookingItem extends StatelessWidget {
  final String title;
  final String subtitle;
  const BookingItem({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(Icons.location_pin),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}
