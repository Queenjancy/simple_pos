import 'package:evlogy_supply/config/theme.config.dart';
import 'package:evlogy_supply/page/home.page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evlogy Supply POS',
      theme: appThemeData(),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
