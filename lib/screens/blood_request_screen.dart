//no data found disappear when there is no data

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sra_qatra/screens/request_blood_screen.dart';
import 'package:sra_qatra/widgets/custom_container.dart';
import 'package:sra_qatra/widgets/custom_text.dart';

import '../services/dimension.dart';

class BloodRequestScreen extends StatefulWidget {
  const BloodRequestScreen({Key? key}) : super(key: key);

  @override
  State<BloodRequestScreen> createState() => _BloodRequestScreenState();
}

class _BloodRequestScreenState extends State<BloodRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: 'Blood Request',),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(244, 66, 54, 1),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('accepters').snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return CustomContainer(
                  checkName: false,
                    location: snapshot.data!.docs[index]['location'],
                    bloodGroup: snapshot.data!.docs[index]['blood_group'],
                    bloodAmount: snapshot.data!.docs[index]['blood_amount'],
                    duration: snapshot.data!.docs[index]['duration'],
                    number: snapshot.data!.docs[index]['phone']);
              },
            );
          } else {
            return  Center(
              child: CustomText(text: 'No Accepter found'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) =>  RequestBloodScreen()));
        },
        label: CustomText(text: 'Be Accepter',fontSize: Dimension.height16,),
        icon: const Icon(Icons.add),
        backgroundColor: const Color.fromRGBO(244, 66, 54, 1),
      ),
    );
  }
}
