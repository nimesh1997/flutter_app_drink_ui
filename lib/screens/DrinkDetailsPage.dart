import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_drink_ui/model/Drink.dart';
import 'package:flutter_app_drink_ui/model/DrinkListModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;

class DrinkDetailsPage extends StatefulWidget {
  DrinkDetailsPage({Key key, this.drink, this.index}) : super(key: key);

  final DrinkData drink;

//  final Drink drink;
  final int index;

  @override
  _DrinkDetailsPageState createState() => _DrinkDetailsPageState();
}

class _DrinkDetailsPageState extends State<DrinkDetailsPage> {
  bool iconSelected = false;

  @override
  Widget build(BuildContext context) {
    print('drink: ' + widget.drink.toString());
    print('index: ' + widget.index.toString());

    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  buildCurveOne(),
                  buildCurveTwo(),
                  buildAppbar(),
                ],
              ),
              buildBottomContainer()
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
        decoration: BoxDecoration(color: Color(int.parse(widget.drink.color)), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50.0))),
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(15 / 360),
          child: Container(
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(widget.drink.imgPath))),
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
                      style: TextStyle(color: Color(int.parse(widget.drink.color)), fontWeight: FontWeight.w500, fontSize: 20.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildBottomContainer() {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 40.0),
      height: 100.0,
      child: Column(
        children: <Widget>[
          Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
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
                child: iconSelected
                    ? IconButton(
                        icon: Icon(Icons.star),
                        onPressed: () {
                          /// todo dynamic store particular drink in likes node
                          iconSelected = false;
                          setState(() {});
                        })
                    : IconButton(
                        icon: Icon(Icons.star_border),
                        onPressed: () {
                          /// todo dynamic store remove particular drink in likes node
                          iconSelected = true;
                          setState(() {});
                        }),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
