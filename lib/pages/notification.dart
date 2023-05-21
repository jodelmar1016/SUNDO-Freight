import 'package:flutter/material.dart';
import 'package:freight/services/dataService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _isLoading = true;
  String userId = '';
  Stream<QuerySnapshot>? notification;

  Future<void> loadData() async {
    await DataService.getUserId();
  }

  @override
  void initState() {
    super.initState();
    loadData();
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
                return ListTile(
                  title: Text('${snapshot.data!.docs[index]['title']}'),
                  subtitle: Text('${snapshot.data!.docs[index]['message']}'),
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
