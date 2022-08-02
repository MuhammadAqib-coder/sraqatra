import 'package:flutter/material.dart';

import '../services/dimension.dart';

class CustomText extends StatelessWidget {
  const CustomText({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: TextStyle(
      color: Colors.white,
      fontSize: Dimension.height16
    ),);
  }
}
