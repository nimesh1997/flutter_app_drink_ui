// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DrinkListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DrinkListModel _$DrinkListModelFromJson(Map<dynamic, dynamic> json) {
  return DrinkListModel((json['data'] as Map<dynamic, dynamic>)?.map(
    (k, e) => MapEntry(
        k, e == null ? null : DrinkData.fromJson(e as Map<dynamic, dynamic>)),
  ));
}

Map<dynamic, dynamic> _$DrinkListModelToJson(DrinkListModel instance) =>
    <dynamic, dynamic>{'data': instance.data};

DrinkData _$DrinkDataFromJson(Map<dynamic, dynamic> json) {
  return DrinkData(
      json['price'] as String,
      json['title'] as String,
      json['subTitle'] as String,
      json['imgPath'] as String,
      json['color'] as String,
      json['rating'] as int,
      json['drinkQuantity'] as String,
      json['description'] as String,
      json['drinkId'] as String);
}

Map<dynamic, dynamic> _$DrinkDataToJson(DrinkData instance) => <dynamic, dynamic>{
      'price': instance.price,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'imgPath': instance.imgPath,
      'color': instance.color,
      'rating': instance.rating,
      'drinkQuantity': instance.drinkQuantity,
      'description': instance.description,
      'drinkId': instance.drinkId
    };
