import 'package:flutter/material.dart';
import 'package:freight/pages/tabs/processing.dart';
import 'package:freight/pages/tabs/completed.dart';
import 'package:freight/pages/tabs/cancelled.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Bookings'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  child: Text(
                    'Processing',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
                Tab(
                  child: Text(
                    'Completed',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
                Tab(
                  child: Text(
                    'Cancelled',
                    style: TextStyle(color: Colors.teal),
                  ),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Processing(),
                  Completed(),
                  Cancelled(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
