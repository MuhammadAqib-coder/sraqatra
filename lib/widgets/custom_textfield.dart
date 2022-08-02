import 'package:flutter/material.dart';

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
        cursorColor: Colors.black,
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
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
            suffixIcon: IconButton(
              icon: Icon(icon),
              color: Colors.black,
              onPressed: onPressed,
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimension.height10),
                borderSide:
                    BorderSide(color: Colors.black, width: Dimension.width2)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimension.height10),
                borderSide:
                    BorderSide(color: Colors.black, width: Dimension.width2)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimension.height10),
                borderSide:
                    BorderSide(color: Colors.black, width: Dimension.width2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimension.height10),
                borderSide:
                    BorderSide(color: Colors.black, width: Dimension.width2))),
      ),
    );
  }
}
