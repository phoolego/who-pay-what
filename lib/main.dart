import 'package:flutter/material.dart';
import 'package:who_pay_what/screen/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Map<int, Color> color =
  {
    50:Color(0x0efc8621),
    100:Color(0x1cfc8621),
    200:Color(0x38fc8621),
    300:Color(0x54fc8621),
    400:Color(0x70fc8621),
    500:Color(0x8cfc8621),
    600:Color(0xa8fc8621),
    700:Color(0xc4fc8621),
    800:Color(0xe0fc8621),
    900:Color(0xFFfc8621),
  };
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFc24914),
        primarySwatch: MaterialColor(0xFFfc8621,color),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}
