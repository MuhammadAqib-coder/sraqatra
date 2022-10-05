import 'package:flutter/material.dart';
import 'package:sra_qatra/res/app_colors.dart';

import '../services/dimension.dart';

class CustomText extends StatelessWidget {
  CustomText({Key? key, required this.text, this.fontSize = 14,this.color=AppColors.whiteColor})
      : super(key: key);
  final String text;
  double? fontSize;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }
}
