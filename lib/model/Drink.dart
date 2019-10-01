import 'package:flutter/material.dart';

class Drink {
  final String price;
  final String title;
  final String subTitle;
  final String imgPath;
  final Color color;
  final int rating;

  /// To store as a Map
  Drink({this.price, this.title, this.subTitle, this.imgPath, this.color, this.rating});

  @override
  String toString() {
    return 'Drink{price: $price, title: $title, subTitle: $subTitle, imgPath: $imgPath, color: $color, rating: $rating}';
  }
}

  /// List of map contains drinks
  List drinkList = [
    Drink(
        price: '\$1299',
        title: 'Mavrose Rose Wine',
        subTitle: '50%Mavrotragano, 50%Avgoustiatis',
        imgPath: 'assets/images/mavrose.png',
        color: Color(0xFFFECBC2),
        rating: 5),
    Drink(
        price: '\$1999',
        title: 'Heavensake',
        subTitle: 'Junmal Ginjo',
        imgPath: 'assets/images/heavensake.png',
        color: Color(0xFFB4E8EB),
        rating: 4),
    Drink(
        price: '\$1299',
        title: 'Mavrose Rose Wine',
        subTitle: '50%Mavrotragano, 50%Avgoustiatis',
        imgPath: 'assets/images/mavrose.png',
        color: Color(0xFFFECBC2),
        rating: 5),
    Drink(
        price: '\$1999',
        title: 'Heavensake',
        subTitle: 'Junmal Ginjo',
        imgPath: 'assets/images/heavensake.png',
        color: Color(0xFFB4E8EB),
        rating: 4
    )
  ];

  /// List of map contains recommendedDrinkList
  List recommendedDrinkList = [
    Drink(
        price: '\$49',
        title: 'Bold Smooth Lush',
        subTitle: 'Camofires + Grilled Cheese',
        imgPath: 'assets/images/canchardonnay.png',
        color: Color(0xFF6CD7DC),
        rating: 5),
    Drink(
        price: '\$669',
        title: 'Bold Smooth Lush',
        subTitle: '70cl Bottle in Giftbox / 40%ABV',
        imgPath: 'assets/images/gin.png',
        color: Color(0xFFF28E90),
        rating: 4),
    Drink(
        price: '\$49',
        title: 'Bold Smooth Lush',
        subTitle: 'Camofires + Grilled Cheese',
        imgPath: 'assets/images/canchardonnay.png',
        color: Color(0xFF6CD7DC),
        rating: 5),
    Drink(
        price: '\$669',
        title: 'Bold Smooth Lush',
        subTitle: '70cl Bottle in Giftbox / 40%ABV',
        imgPath: 'assets/images/gin.png',
        color: Color(0xFFF28E90),
        rating: 4),
  ];
