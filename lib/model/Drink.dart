import 'package:flutter/material.dart';

class Drink {
  final String price;
  final String title;
  final String subTitle;
  final String imgPath;
  final Color color;
  final int rating;
  final String drinkQuantity;

  /// To store as a Map
  Drink({this.price, this.title, this.subTitle, this.imgPath, this.color, this.rating, this.drinkQuantity});

  @override
  String toString() {
    return 'Drink{price: $price, title: $title, subTitle: $subTitle, imgPath: $imgPath, color: $color, rating: $rating, drinkQuantity: $drinkQuantity}';
  }
}

/// List of map contains drinks
List drinkList = [
  Drink(
      price: '\$1299',
      title: 'Mavrose Rose Wine',
      subTitle: '80% Avgoustiatis - 20% Mavrotragano ',
      imgPath: 'assets/images/mavrose.png',
      color: Color(0xFFFECBC2),
      rating: 5,
      drinkQuantity: '750 ml of pale pink color'),
  Drink(
      price: '\$1999',
      title: 'Heavensake',
      subTitle: 'Junmal Ginjo',
      imgPath: 'assets/images/heavensake.png',
      color: Color(0xFFB4E8EB),
      rating: 4,
      drinkQuantity: '720 ml of Franco-Japanese Creation'),
  Drink(
      price: '\$1299',
      title: 'Mavrose Rose Wine',
      subTitle: '50%Mavrotragano, 50%Avgoustiatis',
      imgPath: 'assets/images/mavrose.png',
      color: Color(0xFFFECBC2),
      rating: 5,
      drinkQuantity: '750 ml of pale pink color'),
  Drink(
      price: '\$1999',
      title: 'Heavensake',
      subTitle: 'Junmal Ginjo',
      imgPath: 'assets/images/heavensake.png',
      color: Color(0xFFB4E8EB),
      rating: 4,
      drinkQuantity: '720 ml of Franco-Japanese Creation')
];

/// List of map contains recommendedDrinkList
List recommendedDrinkList = [
  Drink(
      price: '\$49',
      title: 'Bold Smooth Lush',
      subTitle: 'Camofires + Grilled Cheese',
      imgPath: 'assets/images/canchardonnay.png',
      color: Color(0xFF6CD7DC),
      rating: 5,
      drinkQuantity: '375 ml of California Chardonnay'),
  Drink(
      price: '\$669',
      title: 'Bold Smooth Lush',
      subTitle: '70cl Bottle in Giftbox / 40%ABV',
      imgPath: 'assets/images/gin.png',
      color: Color(0xFFF28E90),
      rating: 4,
      drinkQuantity: '500 ml of bold smooth lush wine'),
  Drink(
      price: '\$49',
      title: 'Bold Smooth Lush',
      subTitle: 'Camofires + Grilled Cheese',
      imgPath: 'assets/images/canchardonnay.png',
      color: Color(0xFF6CD7DC),
      rating: 5,
      drinkQuantity: '375 ml of California Chardonnay'),
  Drink(
      price: '\$669',
      title: 'Bold Smooth Lush',
      subTitle: '70cl Bottle in Giftbox / 40%ABV',
      imgPath: 'assets/images/gin.png',
      color: Color(0xFFF28E90),
      rating: 4,
      drinkQuantity: '500 ml of bold smooth lush wine'),
];
