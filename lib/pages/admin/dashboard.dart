import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.notifications),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 600) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Cards(
                    title: '100',
                    subtitle: 'Users',
                    cardColor: Colors.blue.shade100,
                    width: 1,
                    fontSize: 10,
                  ),
                  Cards(
                    title: '50',
                    subtitle: 'Drivers',
                    cardColor: Colors.red.shade100,
                    width: 1,
                    fontSize: 10,
                  ),
                  Cards(
                    title: '700',
                    subtitle: 'Bookings',
                    cardColor: Colors.purple.shade100,
                    width: 1,
                    fontSize: 10,
                  ),
                  Cards(
                    title: '10',
                    subtitle: 'Applications',
                    cardColor: Colors.green.shade100,
                    width: 1,
                    fontSize: 10,
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Cards(
                    title: '100',
                    subtitle: 'Users',
                    cardColor: Colors.blue.shade100,
                    width: 5,
                    fontSize: 30,
                  ),
                  Cards(
                    title: '50',
                    subtitle: 'Drivers',
                    cardColor: Colors.red.shade100,
                    width: 5,
                    fontSize: 30,
                  ),
                  Cards(
                    title: '700',
                    subtitle: 'Bookings',
                    cardColor: Colors.purple.shade100,
                    width: 5,
                    fontSize: 30,
                  ),
                  Cards(
                    title: '10',
                    subtitle: 'Applications',
                    cardColor: Colors.green.shade100,
                    width: 5,
                    fontSize: 30,
                  ),
                ],
              ),
            );
          }
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Admin'),
              accountEmail: Text('admin@gmail.com'),
              currentAccountPicture: CircleAvatar(
                foregroundImage: AssetImage('assets/user.jpg'),
              ),
            ),
            Container(
              color: Colors.blue,
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => HomePage()),
                // );
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.paste),
              title: Text('Bookings'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.book_rounded),
              title: Text('Applications'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Manage Users'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.drive_eta),
              title: Text('Manage Drivers'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color cardColor;
  final int width;
  final int fontSize;
  const Cards({
    super.key,
    required this.title,
    required this.subtitle,
    required this.cardColor,
    required this.width,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / width,
      height: MediaQuery.of(context).size.height / 5,
      child: Card(
        elevation: 2,
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / fontSize,
                    fontWeight: FontWeight.bold),
              ),
              Text(subtitle),
            ],
          ),
        ),
      ),
    );
  }
}
