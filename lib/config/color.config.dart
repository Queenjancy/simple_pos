import 'package:flutter/material.dart';

abstract class AppColors {
  static MaterialColor primaryColor =
      const MaterialColor(0xff222831, <int, Color>{
    50: Color(0xffe4e5e6),
    100: Color(0xffbdbfc1),
    200: Color(0xff919498),
    300: Color(0xff64696f),
    400: Color(0xff434850),
    500: Color(0xff222831),
    600: Color(0xff1e242c),
    700: Color(0xff191e25),
    800: Color(0xff14181f),
    900: Color(0xff0c0f13)
  });

  static MaterialColor skyBlueColor =
      const MaterialColor(0xff00adb5, <int, Color>{
        50: Color(0xffe0f5f6),
        100: Color(0xffb3e6e9),
        200: Color(0xff80d6da),
        300: Color(0xff4dc6cb),
        400: Color(0xff26b9c0),
        500: Color(0xff00adb5),
        600: Color(0xff00a6ae),
        700: Color(0xff009ca5),
        800: Color(0xff00939d),
        900: Color(0xff00838d)
      });
}
