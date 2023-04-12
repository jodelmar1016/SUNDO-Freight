import 'package:flutter/material.dart';
import 'package:freight/pages/user/bookCargo.dart';
import 'package:freight/pages/user/myBookings.dart';
import 'package:freight/pages/user/fare.dart';
import 'package:freight/router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // HEADER ------------------------------->
    Widget header = Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.teal,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(
                    color: Colors.teal[50],
                    fontSize: 40,
                  ),
                ),
                Text(
                  'Simplifying Logistics in the digital age',
                  style: TextStyle(
                    color: Colors.teal[50],
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Text(
                  'Track your Cargo',
                  style: TextStyle(
                    color: Colors.teal[50],
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    // prefixIcon: Icon(Icons.numbers),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                    hintText: 'Tracking No.',
                    // hintStyle: TextStyle(color: Colors.teal[800]),
                    filled: true,
                    fillColor: Colors.teal[100],
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(width: 0),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );

    // SERVICES ------------------------------------->
    Widget services = Card(
      elevation: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookCargo()),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 4,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_box_rounded,
                    size: 30,
                    color: Colors.teal,
                  ),
                  Text(
                    'Book Cargo',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyBookings()),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 4,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.paste,
                    size: 30,
                    color: Colors.teal,
                  ),
                  Text(
                    'My Bookings',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Fare()),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 4,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calculate_rounded,
                    size: 30,
                    color: Colors.teal,
                  ),
                  Text(
                    'Fare',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // PROMOTIONS
    Widget promotions = Container(
      width: double.infinity,
      height: 200,
      color: Colors.grey[300],
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header,
                const SizedBox(height: 30),
                const Text(
                  'Services',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                services,
                const SizedBox(height: 30),
                const Text(
                  'Promotions',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                promotions,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
