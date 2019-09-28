import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_drink_ui/model/Drink.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          buildBody(),
          buildAppBar(),
          Container(
            padding: EdgeInsets.only(left: 12.0, top: 50.0),
            child: Column(
              children: <Widget>[
                buildTile(),
                buildList(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildAppBar() {
    return Container(
      height: 50.0,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              ),
              padding: EdgeInsets.all(0.0),
              onPressed: () {
                exit(0);
              }),
          Container(
            width: 50.0,
            height: 50.0,
            child: Stack(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.notifications, color: Colors.grey),
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: "Coming Soon",
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 12.0);
                    }),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      margin: EdgeInsets.only(left: 14.0, top: 10.0),
                      width: 12.0,
                      height: 12.0,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                      child: Center(
                          child: Text(
                        '1',
                        style: TextStyle(fontSize: 8.0, color: Colors.white, fontWeight: FontWeight.bold),
                        textScaleFactor: 1.0,
                      ))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildBody() {
    return Container(
      height: 400.0,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(
                  0.2,
                ),
                spreadRadius: 10.0,
                blurRadius: 14.0)
          ]),
    );
  }

  Widget buildTile() {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            'List',
            style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }

  Widget buildListItem(int index) {
    return Padding(
      padding: EdgeInsets.only(top: 12.0, bottom: 10.0, left: 10.0, right: 10.0),
      child: Container(
        width: 200.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4.0, spreadRadius: 5.0)]),
        child: Stack(
          children: <Widget>[
            Container(
              height: 160.0,
              width: 200.0,
              decoration: BoxDecoration(
                  color: drinkList[index].color, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                height: 120.0,
                width: 200.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                    image: DecorationImage(image: AssetImage(drinkList[index].imgPath))),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      drinkList[index].price,
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                    InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: 16.0,
                        )),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  buildList() {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      height: 280.0,
      width: MediaQuery.of(context).size.width,
//      alignment: Alignment.bottomCenter,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: drinkList.length,
          itemBuilder: (context, index) {
            print('item: ${drinkList[index].toString()}');
            return buildListItem(index);
          }),
    );
  }
}
