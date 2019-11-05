import 'package:flutter/material.dart';
import 'package:flutter_app_drink_ui/screens/LoginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Drink Ui',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: LoginPage()),
    );
  }
}
