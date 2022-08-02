import 'package:flutter/material.dart';
import 'package:sra_qatra/screens/request_blood_screen.dart';
import 'package:sra_qatra/widgets/custom_container.dart';

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
        title: const Text("Blood Request"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(244, 66, 54, 1),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return CustomContainer(
              onPressed: () {},
              location: "islamabad",
              bloodGroup: 'AB+',
              name: "saqib",
              gender: 'male',
              number: '1234567890');
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => RequestBloodScreen()));
        },
        label: Text(
          'be accepter',
          style: TextStyle(fontSize: Dimension.height16),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: const Color.fromRGBO(244, 66, 54, 1),
      ),
    );
  }
}
