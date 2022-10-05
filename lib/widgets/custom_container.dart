import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import '../services/dimension.dart';

class CustomContainer extends StatelessWidget {
  final String location;
  final String bloodGroup;
  String? name;
  final bool checkName;
  String? gender;
  final String number;
  String? bloodAmount;
  String? duration;
  CustomContainer(
      {Key? key,
      required this.location,
      required this.bloodGroup,
      this.name,
      this.gender,
      this.bloodAmount,
      this.duration,
      required this.number,
      required this.checkName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
              width: Dimension.width10,
            ),
            MiddleContainer(
              bloodAmount: bloodAmount,
              duration: duration,
              name: name,
              gender: gender,
              number: number,
              checkName: checkName,
            )
          ],
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
    return Container(
      margin: EdgeInsets.only(left: Dimension.width5),
      padding: EdgeInsets.only(left: Dimension.width5, right: Dimension.width5),
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
          color: AppColors.redColor,
          borderRadius: BorderRadius.circular(Dimension.height10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            textAlign: TextAlign.center,
            location,
            style: TextStyle(color: Colors.white, fontSize: Dimension.height18),
          ),
          Text(
            textAlign: TextAlign.center,
            bloodGroup,
            style: TextStyle(fontSize: Dimension.height22, color: Colors.white),
          )
        ],
      ),
    );
  }
}

class MiddleContainer extends StatelessWidget {
  String? name;
  String? gender;
  final String number;
  String? bloodAmount;
  String? duration;
  final bool checkName;
  MiddleContainer(
      {Key? key,
      this.bloodAmount,
      this.name,
      this.gender,
      this.duration,
      required this.number,
      required this.checkName})
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
            checkName ? name! : bloodAmount!,
            style: TextStyle(fontSize: Dimension.height16),
          ),
          Expanded(
            child: Row(
              children: [
                Icon(checkName ? Icons.girl_outlined : Icons.access_time_sharp),
                SizedBox(
                  width: Dimension.width10,
                ),
                Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  checkName ? gender! : duration!,
                  style: TextStyle(fontSize: Dimension.height16),
                ),
              ],
            ),
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
