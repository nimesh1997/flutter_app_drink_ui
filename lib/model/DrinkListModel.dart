import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'DrinkListModel.g.dart';

class DrinkListModel {

  @JsonKey(name: 'normalList')
  List<DrinkData> normalList;
  @JsonKey(name: 'recommendList')
  List<DrinkData> recommendList;

  factory DrinkListModel.fromJson(Map<String, dynamic> json) => _$DrinkListModelFromJson(json);

  Map<String, dynamic> toJson() => _$DrinkListModelToJson(this)

}

@JsonSerializable()
class DrinkData {
  String price;
  String title;
  String subTitle;
  String imgPath;
  String color;
  int rating;
  String drinkQuantity;

  DrinkData(this.price, this.title, this.subTitle, this.imgPath, this.color, this.rating, this.drinkQuantity);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory DrinkData.fromJson(Map<String, dynamic> json) => _$DrinkDataFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$DrinkDataToJson(this);
}
