import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.size,
  );

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    final Gradient gradient = LinearGradient(
      colors: <Color>[Color(0xffF4E9AD), Color(0xffCB915E)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
