import 'package:flutter/material.dart';
import 'package:sra_qatra/res/app_colors.dart';
import 'package:sra_qatra/services/dimension.dart';

class NextContainer extends StatelessWidget {
  const NextContainer({Key? key, required this.icon}) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: 45,
        child: Container(
          width: Dimension.width50,
          height: Dimension.height50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimension.height10),
            color: AppColors.redColor,
          ),
          child: Transform.rotate(
            angle: -45,
            child: Icon(
              icon,
              color: AppColors.whiteColor,
            ),
          ),
        ));
  }
}
