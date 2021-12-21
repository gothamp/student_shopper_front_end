// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryItemModel _$CategoryItemModelFromJson(Map<String, dynamic> json) =>
    CategoryItemModel()
      ..categoryId = json['categoryId'] as int
      ..categoryItems = (json['categoryItems'] as List<dynamic>)
          .map((e) => ItemRest.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CategoryItemModelToJson(CategoryItemModel instance) =>
    <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryItems': instance.categoryItems.map((e) => e.toJson()).toList(),
    };

CategoryItemPage _$CategoryItemPageFromJson(Map<String, dynamic> json) =>
    CategoryItemPage(
      (json['categoryItemList'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryItemPageToJson(CategoryItemPage instance) =>
    <String, dynamic>{
      'categoryItemList':
          instance.categoryItemList.map((e) => e.toJson()).toList(),
    };
