import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_drink_ui/model/Drink.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;

class DrinkDetailsPage extends StatefulWidget {
  DrinkDetailsPage({Key key, this.drink, this.index}) : super(key: key);

  final Drink drink;
  final int index;

  @override
  _DrinkDetailsPageState createState() => _DrinkDetailsPageState();
}

class _DrinkDetailsPageState extends State<DrinkDetailsPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              buildCurveOne(),
              buildCurveTwo(),
              buildAppbar(),
            ],
          )),
    );
  }

  buildAppbar() {
    return Container(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }),
          IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Colors.white,
              onPressed: () {
                Fluttertoast.showToast(
                    msg: 'Coming Soon', toastLength: Toast.LENGTH_SHORT, backgroundColor: Colors.black, textColor: Colors.white, fontSize: 12.0);
              })
        ],
      ),
    );
  }

  buildCurveTwo() {
    return Hero(
      tag: widget.drink.imgPath + widget.index.toString(),
      child: Container(
        alignment: Alignment.center,
        height: 350.0,
        decoration: BoxDecoration(color: widget.drink.color, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0))),
        child: Transform.rotate(
          angle: math.pi /4,
          child: Container(
            width: 150.0,
            height: 200.0,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(widget.drink.imgPath))),
//            child: Image.asset(widget.drink.imgPath)
          ),
        ),
      ),
    );
  }

  buildCurveOne() {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 500.0,
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 40.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0)),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 14.0, spreadRadius: 10.0)]),
      child: Container(
        height: 100.0,
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.drink.title,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20.0),
                    ),
                    Text(
                      widget.drink.subTitle,
                      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 14.0),
                    )
                  ],
                ),
                SizedBox(
                  height: 2.0,
                ),
                Container(
                  child: Center(
                    child: Text(
                      widget.drink.price,
                      style: TextStyle(color: widget.drink.color, fontWeight: FontWeight.w500, fontSize: 20.0),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
