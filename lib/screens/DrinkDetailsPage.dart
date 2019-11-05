import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_drink_ui/model/DrinkListModel.dart';
import 'package:flutter_app_drink_ui/screens/HomePage.dart';
import 'package:flutter_app_drink_ui/screens/LoginPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math' as math;

class DrinkDetailsPage extends StatefulWidget {
  DrinkDetailsPage({Key key, this.drink, this.index}) : super(key: key);

  final DrinkData drink;

  final int index;

  @override
  _DrinkDetailsPageState createState() => _DrinkDetailsPageState();
}

class _DrinkDetailsPageState extends State<DrinkDetailsPage> {
  bool iconSelected = false;
  int drinkId;

  @override
  void initState() {
    super.initState();
    getDrinkId();
  }

  @override
  Widget build(BuildContext context) {
    print('build Called...');
//    print('iconSelected status: ' + iconSelected.toString());

    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Container(
        width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Column(
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
              ),
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
            width: 220.0,
            height: 220.0,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 1.35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.drink.titleTop,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16.0),
                      ),
                      Text(
                        widget.drink.subTitleTop,
                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.0,
                ),
                Container(
                  child: Center(
                    child: Text(
                      widget.drink.price,
                      style: TextStyle(color: Color(int.parse(widget.drink.color)),
                          fontWeight: FontWeight.w500,
                          fontSize: 26.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              widget.drink.drinkQuantity,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14.0),
            ),
            Text(
              widget.drink.descriptionTop,
                textScaleFactor: 1,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }

  buildBottomContainer() {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
//      height: 100.0,
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.drink.titleBottom,
                    textScaleFactor: 1,
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16.0),
                  ),
                  Text(
                    widget.drink.subTitleBottom,
                    textScaleFactor: 1,
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14.0),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Container(
              child: Center(
                child: iconSelected
                    ? IconButton(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.all(0.0),
                        icon: Icon(Icons.star),
                        onPressed: () {
                          /// todo dynamic store particular drink in likes node
                          iconSelected = false;
                          addDrinkToLikesNode(iconSelected);
                          setState(() {});
                        })
                    : IconButton(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.all(0.0),
                        icon: Icon(Icons.star_border),
                        onPressed: () {
                          /// todo dynamic store remove particular drink in likes node
                          iconSelected = true;
                          addDrinkToLikesNode(iconSelected);
                          setState(() {});
                        }),
              ),
            ),
          ]),
          SizedBox(height: 12,),
          Text(
            widget.drink.descriptionBottom,
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14.0),
          ),
          SizedBox(height: 12,),
        ],
      ),
    );
  }

  void addDrinkToLikesNode(bool selected) async {
    await FirebaseDatabase.instance.reference()
        .child('likes')
        .child(firebaseUser.phoneNumber)
        .update({widget.drink.drinkId: selected});
  }

  void getDrinkId() async {
    print('getDrinkId Called');
    print('likes data: ' + likes.toString());
    likes.forEach((k, v) {
      if (widget.drink.drinkId == k) {
        print('key is: ' + k);
        print('value is: ' + v.toString());
        setState(() {
          iconSelected = v;
          print(iconSelected);
        });
      }
    });
    print('after setState: ' + iconSelected.toString());
  }
}
