import 'package:flutter/material.dart';
import 'package:flutter_app_drink_ui/model/Drink.dart';

class DrinkDetailsPage extends StatefulWidget {

  DrinkDetailsPage({Key key, this.drink}) : super(key: key);

  final Drink drink;

  @override
  _DrinkDetailsPageState createState() => _DrinkDetailsPageState();
}

class _DrinkDetailsPageState extends State<DrinkDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: Text(widget.drink.title),
      ),
    ));
  }
}
