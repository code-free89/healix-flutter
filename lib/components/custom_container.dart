import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {

  final Widget child;

  const CustomContainer({super.key , required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipPath(),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color.fromRGBO(28, 197, 116, 1)
        ),
        child: child,
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;

    final path = Path();

    path.lineTo(0, 0);
    path.quadraticBezierTo(w/1.7, h/5, w, 15);
    path.lineTo(w, h);
    path.lineTo(0, h);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return false;
  }
}