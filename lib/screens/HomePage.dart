import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_drink_ui/model/DrinkListModel.dart';
import 'package:flutter_app_drink_ui/model/User.dart';
import 'package:flutter_app_drink_ui/screens/DrinkDetailsPage.dart';
import 'package:flutter_app_drink_ui/screens/LoginPage.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

List<DrinkData> drinkDataList = [];
List<DrinkData> recommendDrinkDataList = [];
Map<dynamic, dynamic> likes = Map();

class _HomePageState extends State<HomePage> {
  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  bool isFetchDataAvailable = false;

  @override
  void initState() {
    print('initState Called');
    /// listener attached for handling the child added or changed
    _onTodoAddedSubscription = FirebaseDatabase.instance
        .reference()
        .child('likes')
        .child(firebaseUser.phoneNumber).onChildAdded.listen(_onEntryAdded);
    _onTodoChangedSubscription = FirebaseDatabase.instance
        .reference()
        .child('likes')
        .child(firebaseUser.phoneNumber).onChildChanged.listen(_onEntryChanged);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _onTodoChangedSubscription.cancel();
    _onTodoAddedSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    if(!isFetchDataAvailable){
      getDataFromFirebase();

      return Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(),
        ),
      );
    }else{

      return Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  buildBody(),
                  buildAppBar(),
                  Container(
                    padding: EdgeInsets.only(left: 12.0, top: 50.0),
                    child: Column(
                      children: <Widget>[
                        buildTile('List'),
                        buildList(drinkDataList),
                      ],
                    ),
                  )
                ],
              ),
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 12.0, top: 10.0),
                    child: Column(
                      children: <Widget>[
                        buildTile('Recommend'),
                        buildList(recommendDrinkDataList),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }
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
                      signOut();
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

  Widget buildTile(String titleName) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            titleName,
            style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }

  ///this method create the list which contains the drink items
  buildList(List<dynamic> items) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      height: 280.0,
      width: MediaQuery.of(context).size.width,
//      alignment: Alignment.bottomCenter,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            print('item: ${items[index].toString()}');
            return buildListItem(index, items);
          }),
    );
  }

  ///this method creates the each drink items
  Widget buildListItem(int index, List<dynamic> items) {
    return Padding(
      padding: EdgeInsets.only(top: 12.0, bottom: 10.0, left: 10.0, right: 10.0),
      child: InkWell(
        onTap: () {
          ///Todo new detail screen open on tap of particular list item
          ///for hero transition using material page route

          print('HomePage: ' + items[index].title);
          print('HomePage index: ' + index.toString());
          print('tag:' + items[index].imgPath + index.toString());

          Navigator.push(context, MaterialPageRoute(
//                  fullscreenDialog: true,
              builder: (_) {
            return DrinkDetailsPage(
              drink: items[index],
              index: index,
            );
          }));
        },
        child: Container(
          width: 200.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4.0, spreadRadius: 5.0)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 160.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                        color: Color(int.parse(items[index].color)),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Hero(
                      tag: items[index].imgPath + index.toString(),
                      child: Container(
                        height: 120.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
                            image: DecorationImage(image: NetworkImage(items[index].imgPath))),
                      ),
                    ),
//                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            items[index].price,
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
                      )),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                child: Text(
                  items[index].title,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300, color: Colors.black),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  items[index].subTitle,
                  style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300, color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Row(
                      children: getStarRating(items[index].rating),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        (items[index].rating / 1.0).toString(),
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Color(0xFFB4E8EB)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// this method requires the rating parameter which tells the rating of the wine
  /// in this method on the basis of rating it makes the star with color filled or simple star
  List<Widget> getStarRating(int rating) {
    List<Widget> wid = [];
    for (int i = 0; i < 5; i++) {
      if (i < rating) {
        wid.add(Icon(
          Icons.star,
          color: Color(0xFFB4E8EB),
        ));
      } else {
        wid.add(Icon(
          Icons.star_border,
          color: Color(0xFFB4E8EB),
        ));
      }
    }
    return wid;
  }

  /// this method fetch data from Firebase
  void getDataFromFirebase() async {
    print('getDataFromFirebase Called');

    /// Testing for something
//    FirebaseDatabase.instance.reference().child('users').child(firebaseUser.phoneNumber).once().then((DataSnapshot snapShot){
//      print('initial Value: ' +snapShot.value.toString());
//      var data = snapShot.value as Map;
//      User userData;
//      userData = User.fromJson(data);
//      print(userData.toString());
//      data.forEach((k,v){
//        print('k is: ' + k);
//        print('v is: ' + v.toString());
//        User.fromJson(v);
//      });

    }).catchError((onError){
      print('initial onError: ' + onError.toString());
    });



    Future<void> future1 = FirebaseDatabase.instance
        .reference()
        .child('drinks')
        .child('drinkList')
        .child('normalList')
        .once()
        .then((DataSnapshot datasnapshot) {
      if (datasnapshot != null) {
        var data = datasnapshot.value as Map;
        print('length: ' + data.length.toString());
        data.forEach((key, value) {
          print('Key is:' + key);
          print('value is:' + value.toString());
          drinkDataList.add(DrinkData.fromJson(value as Map));
        });
      } else {
        print('dataSnapShot is null');
      }
    }).catchError((onError) {
      print('catchError: ' + onError.toString());
    });

    Future<void> future2 = FirebaseDatabase.instance
        .reference()
        .child('drinks')
        .child('drinkList')
        .child('recommendList')
        .once()
        .then((DataSnapshot datasnapshot) {
      if (datasnapshot != null) {
        var data = datasnapshot.value as Map;

        print('dataSnapShot:' + datasnapshot.value.toString());

        data.forEach((key, value) {
          print('Key is:' + key);
          print('value is:' + value.toString());
          recommendDrinkDataList.add(DrinkData.fromJson(value as Map));
        });
      } else {
        print('dataSnapShot is null');
      }
    }).catchError((onError) {
      print('catchError: ' + onError.toString());
    });
    
    Future<void> future3 = FirebaseDatabase.instance
        .reference()
        .child('likes')
        .child(firebaseUser.phoneNumber)
        .once()
        .then((snapShot){
      if(snapShot.value != null){
        print('future3 snapShot:' + snapShot.value.toString());

        var data = snapShot.value as Map<dynamic, dynamic>;
        data.forEach((k,v){
          print('key is: ' + k);
          print('value is: ' + v.toString());
        });
        likes = snapShot.value as Map<dynamic, dynamic>;
        print('likes: ' + likes.toString());
      }
    }).catchError((onError){
      print('future3 catchError: ' + onError.toString());
    });

    Future.wait([future1, future2, future3]).then((onValue) {
      print('data fetch successfully');
      setState(() {
        isFetchDataAvailable = true;
      });
    }).catchError((onError) {
      print('catchError Called...' + onError.toString());
    });
  }

  void _onEntryAdded(Event event) {
    print('onEntryAdded Called');
    setState(() {
      print(event.snapshot.key);
      print(event.snapshot.value);
      likes[event.snapshot.key] = event.snapshot.value;

    });
  }

  void _onEntryChanged(Event event) {
    print('onEntryChanged Called');
    var value = event.snapshot.key;
    setState(() {
      likes[value] = event.snapshot.value;
    });
  }

  void signOut() async{
    print('signOut Called');
    await firebaseAuth.signOut();
    setState(() {
      phoneNumber = '';
      firebaseAuth = null;
      firebaseUser = null;
      drinkDataList = [];
      recommendDrinkDataList = [];
      likes = Map();
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Material(child: LoginPage())));
  }
}
