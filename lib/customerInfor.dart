import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerinfor/addcustomer.dart';

import 'package:customerinfor/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ShowInfor extends StatefulWidget {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  _ShowInforState createState() => _ShowInforState();
}

class _ShowInforState extends State<ShowInfor> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Information'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("people").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView(
              children: snapshot.data.docs.map(
                (document) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.amberAccent.shade400, width: 2),
                      ),
                      alignment: Alignment.center,
                      height: 100,
                      child: ListTile(
                        leading: FittedBox(
                          child: Text(
                            "Name " + document["name"],
                            style: fontDisplay(),
                          ),
                        ),
                        title: Text(
                          "Age " + document["age"],
                          style: fontDisplay(),
                        ),
                        subtitle: Text(
                          "Address " +
                              document['address'] +
                              ('    ') +
                              "Phone " +
                              document['phoneNumber'],
                          style: fontDisplay(),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goTo(context, AddCustomerInfor());
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }
}

void goTo(context, Widget w) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => w),
  );
}
