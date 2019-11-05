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
      json['color'] as String,
      json['descriptionTop'] as String,
      json['drinkId'] as String,
      json['drinkQuantity'] as String,
      json['imgPath'] as String,
      json['price'] as String,
      json['rating'] as int,
      json['subTitleTop'] as String,
      json['titleTop'] as String,
      json['subTitleBottom'] as String,
      json['titleBottom'] as String,
      json['descriptionBottom'] as String);
}

Map<dynamic, dynamic> _$DrinkDataToJson(DrinkData instance) => <dynamic, dynamic>{
      'color': instance.color,
      'descriptionTop': instance.descriptionTop,
      'drinkId': instance.drinkId,
      'drinkQuantity': instance.drinkQuantity,
      'imgPath': instance.imgPath,
      'price': instance.price,
      'rating': instance.rating,
      'subTitleTop': instance.subTitleTop,
      'titleTop': instance.titleTop,
      'subTitleBottom': instance.subTitleBottom,
      'titleBottom': instance.titleBottom,
      'descriptionBottom': instance.descriptionBottom
    };
