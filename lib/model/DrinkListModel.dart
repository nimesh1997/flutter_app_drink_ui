import 'package:json_annotation/json_annotation.dart';

/// flutter packages pub run build_runner build
/// flutter packages pub run build_runner build --delete-conflicting-outputs

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'DrinkListModel.g.dart';

@JsonSerializable()
class DrinkListModel {
  DrinkListModel(this.data);

  Map<dynamic, DrinkData> data;

  factory DrinkListModel.fromJson(Map<dynamic, dynamic> json) => _$DrinkListModelFromJson(json);

  Map<dynamic, dynamic> toJson() => _$DrinkListModelToJson(this);
}

@JsonSerializable()
class DrinkData {
//  DrinkData(this.price, this.title, this.subTitle, this.imgPath, this.color, this.rating, this.drinkQuantity, this.description, this.drinkId);
//
//  String price;
//  String title;
//  String subTitle;
//  String imgPath;
//  String color;
//  int rating;
//  String drinkQuantity;
//  String description;
//  String drinkId;

  DrinkData(this.color, this.descriptionTop, this.drinkId, this.drinkQuantity, this.imgPath, this.price, this.rating, this.subTitleTop, this.titleTop,
      this.subTitleBottom, this.titleBottom, this.descriptionBottom);
  String color;
  String descriptionTop;
  String drinkId;
  String drinkQuantity;
  String imgPath;
  String price;
  int rating;
  String subTitleTop;
  String titleTop;
  String subTitleBottom;
  String titleBottom;


  String descriptionBottom;

  factory DrinkData.fromJson(Map<dynamic, dynamic> json) => _$DrinkDataFromJson(json);

  Map<dynamic, dynamic> toJson() => _$DrinkDataToJson(this);
}
