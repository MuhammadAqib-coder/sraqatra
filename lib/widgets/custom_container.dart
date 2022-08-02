import 'package:flutter/material.dart';

import '../services/dimension.dart';

class CustomContainer extends StatelessWidget {
  final VoidCallback onPressed;
  final String location;
  final String bloodGroup;
  final String name;
  final String gender;
  final String number;
  const CustomContainer(
      {Key? key,
      required this.onPressed,
      required this.location,
      required this.bloodGroup,
      required this.name,
      required this.gender,
      required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimension.height15)),
          child: Row(
            children: [
              LeadingPart(
                location: location,
                bloodGroup: bloodGroup,
              ),
              SizedBox(
                width: Dimension.width20,
              ),
              MiddleContainer(
                name: name,
                gender: gender,
                number: number,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LeadingPart extends StatelessWidget {
  final String location;
  final String bloodGroup;
  const LeadingPart(
      {Key? key, required this.location, required this.bloodGroup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding:
            EdgeInsets.only(left: Dimension.width5, right: Dimension.width5),
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(244, 66, 54, 1),
            borderRadius: BorderRadius.circular(Dimension.height10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              location,
              style:
                  TextStyle(color: Colors.white, fontSize: Dimension.height20),
            ),
            Text(
              bloodGroup,
              style:
                  TextStyle(fontSize: Dimension.height22, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class MiddleContainer extends StatelessWidget {
  final String name;
  final String gender;
  final String number;
  const MiddleContainer(
      {Key? key,
      required this.name,
      required this.gender,
      required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: Dimension.height16),
          ),
          Row(
            children: [
              const Icon(Icons.girl_outlined),
              SizedBox(
                width: Dimension.width10,
              ),
              Text(
                gender,
                style: TextStyle(fontSize: Dimension.height16),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.phone),
              SizedBox(
                width: Dimension.width10,
              ),
              Text(number)
            ],
          )
        ],
      ),
    );
  }
}
