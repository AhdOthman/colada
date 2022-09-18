import 'package:flutter/material.dart';

class CardClipper extends CustomClipper<Path> {
  double punchRadius;
  CardClipper(this.punchRadius);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.addOval(Rect.fromCircle(
        center: Offset(0, size.height / 2), radius: punchRadius));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 2), radius: punchRadius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
