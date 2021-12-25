import 'package:flutter/material.dart';
import 'package:irrigador/screens/shop_screen.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Plant Shop UI',
      theme: ThemeData(
        primaryColor: Color(0xff9dd6bb),
        accentColor: Color(0xff9dd6bb)
      ),
      debugShowCheckedModeBanner: false,
      home: ShopScreen(),
    );
  }
}
