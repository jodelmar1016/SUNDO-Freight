import 'package:flutter/material.dart';
import 'package:freight/services/dataService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freight/functions/functions.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // SHOW A DIALOG
  void _showNotification(BuildContext context, DocumentSnapshot snapshot) {
    if (snapshot['unread'] == true) {
      // MARK AS READ
      DataService.markAsReadNotification(snapshot.id);
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(snapshot['title']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(snapshot['message']),
              Text('${formatToDate(snapshot['timestamp'])}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DataService.getNotification(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                if (snapshot.data!.docs[index]['unread'] == true)
                  return ListTile(
                    title: Text('${snapshot.data!.docs[index]['title']}'),
                    subtitle: Text('${snapshot.data!.docs[index]['message']}'),
                    trailing: Text(
                        '${formatToDate(snapshot.data!.docs[index]['timestamp'])}'),
                    tileColor: Colors.blue[50],
                    shape:
                        Border(bottom: BorderSide(color: Colors.grey.shade300)),
                    onTap: () {
                      _showNotification(context, snapshot.data!.docs[index]);
                    },
                  );
                if (snapshot.data!.docs[index]['unread'] == false)
                  return ListTile(
                    title: Text('${snapshot.data!.docs[index]['title']}'),
                    subtitle: Text('${snapshot.data!.docs[index]['message']}'),
                    trailing: Text(
                        '${formatToDate(snapshot.data!.docs[index]['timestamp'])}'),
                    shape:
                        Border(bottom: BorderSide(color: Colors.grey.shade300)),
                    onTap: () {
                      _showNotification(context, snapshot.data!.docs[index]);
                    },
                  );
              },
            );
          }
        }
        return Container();
      },
    );
  }
}
