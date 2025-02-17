import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/formscreen.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายงานคะแนนสอบ'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('student').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: snapshot.data!.docs.map((document) {
                  return Container(
                    child: Card(
                      child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            child: FittedBox(child: Text(document['score'])),
                          ),
                          title:
                              Text(document['fname'] + " " + document['lname']),
                          subtitle: Text(document['email']),
                          trailing: Icon(Icons.delete_rounded),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormScreen(),
                                  settings: RouteSettings(arguments: document
                                  ),
                                ));
                          },
                          ),
                    ),
                  );
                }).toList(),
              );
            }
          }),
    );
  }
}
