import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Imran extends StatelessWidget {
  const Imran({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: ClipPath(
          clipper: CustomShape(),
          child: Container(
            height: 150,
            width: double.infinity,
            color: Colors.black,
          ),
        ));
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
