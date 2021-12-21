// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recentItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentItemPage _$RecentItemPageFromJson(Map<String, dynamic> json) =>
    RecentItemPage(
      (json['recentItemList'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecentItemPageToJson(RecentItemPage instance) =>
    <String, dynamic>{
      'recentItemList': instance.recentItemList.map((e) => e.toJson()).toList(),
    };

RecentItemModel _$RecentItemModelFromJson(Map<String, dynamic> json) =>
    RecentItemModel();

Map<String, dynamic> _$RecentItemModelToJson(RecentItemModel instance) =>
    <String, dynamic>{};
