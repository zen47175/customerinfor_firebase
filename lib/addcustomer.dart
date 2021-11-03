import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerinfor/service/customer.dart';
import 'package:customerinfor/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddCustomerInfor extends StatefulWidget {
  @override
  _AddCustomerInforState createState() => _AddCustomerInforState();
}

class _AddCustomerInforState extends State<AddCustomerInfor> {
  final textcontrol = TextEditingController();

  _AddCustomerInforState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create new customer Information',
          style: fontDisplay(),
        ),
      ),
      body: AddCustomer(),
    );
  }
}

class AddCustomer extends StatefulWidget {
  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final formKey = GlobalKey<FormState>();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference peoples = FirebaseFirestore.instance.collection("people");
  TextEditingController nameText = TextEditingController();
  TextEditingController agetext = TextEditingController();
  TextEditingController adresstext = TextEditingController();
  TextEditingController phoneNumtext = TextEditingController();

  final People people = People();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(child: Text('No data')),
          );
        }
        if (snapshot.connectionState == ConnectionState.done)
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.person_add),
                        hintText: 'Full Name',
                        labelText: 'Name'),
                    controller: nameText,
                    onSaved: (String name) {
                      people.name = name;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.person_pin_rounded),
                        hintText: '0',
                        labelText: 'Age'),
                    controller: agetext,
                    onSaved: (String age) {
                      people.age = age;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.phone),
                        hintText: '0864193178',
                        labelText: 'Phone Number'),
                    controller: phoneNumtext,
                    onSaved: (String phonNumber) {
                      people.phoneNumber = phonNumber;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.maps_home_work),
                        hintText: '67/2 road',
                        labelText: 'Address'),
                    controller: adresstext,
                    onSaved: (String address) {
                      people.address = address;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Map<String, dynamic> people = {
                        "name": nameText.text,
                        "age": agetext.text,
                        "phoneNumber": phoneNumtext.text,
                        "address": adresstext.text,
                      };
                      FirebaseFirestore.instance
                          .collection("people")
                          .add(people);
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.add),
                    label: Text('ADD Customer'),
                  )
                ],
              ),
            ),
          );
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
