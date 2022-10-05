import 'package:flutter/material.dart';
import 'package:sra_qatra/res/app_colors.dart';

import '../services/dimension.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String labelText;
  bool textObsecure;
  TextEditingController? controller;
  VoidCallback? onPressed;
  TextInputType? type;
  int? length;
  CustomTextField(
      {Key? key,
      this.onPressed,
      required this.icon,
      required this.labelText,
      this.controller,
      this.textObsecure = false,
      this.type,
      this.length})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimension.height10),
      height: MediaQuery.of(context).size.height * 0.09,
      child: TextFormField(
        maxLength: length,
        keyboardType: type,
        obscureText: textObsecure,
        cursorColor: AppColors.redColor,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "please fill the field";
          }
          return null;
        },
        decoration: InputDecoration(
            counterText: '',
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            labelText: labelText,
            labelStyle: TextStyle(
              color: AppColors.redColor,
            ),
            suffixIcon: IconButton(
              icon: Icon(icon),
              color: AppColors.redColor,
              onPressed: onPressed,
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimension.height10),
                borderSide: BorderSide(
                    color: AppColors.redColor, width: Dimension.width2)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimension.height10),
                borderSide: BorderSide(
                    color: AppColors.redColor, width: Dimension.width2)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimension.height10),
                borderSide: BorderSide(
                    color: AppColors.redColor, width: Dimension.width2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimension.height10),
                borderSide: BorderSide(
                    color: AppColors.redColor, width: Dimension.width2))),
      ),
    );
  }
}
