import 'package:flutter/material.dart';

const Color primaryColor = Color(0xff003F37);
const Color secondaryColor = Color(0xffD7B240);
const String appUrl = "https://staging.servconmain.com/storage/";

final Shader linearGradient = const LinearGradient(
  colors: <Color>[Color(0xffF4E9AD), Color(0xffCB915E)],
).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

ButtonStyle elevatedButton(width) {
  return ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: primaryColor,
    elevation: 0,
    fixedSize: Size(width, 15),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)),
  );
}