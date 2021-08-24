// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemPage _$ItemPageFromJson(Map<String, dynamic> json) {
  return ItemPage(
    (json['itemList'] as List<dynamic>)
        .map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ItemPageToJson(ItemPage instance) => <String, dynamic>{
      'itemList': instance.itemList,
    };

ItemRest _$ItemRestFromJson(Map<String, dynamic> json) {
  return ItemRest(
    Item.fromJson(json['item'] as Map<String, dynamic>),
    (json['itemImageList'] as List<dynamic>).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$ItemRestToJson(ItemRest instance) => <String, dynamic>{
      'item': instance.item,
      'itemImageList': instance.itemImageList,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    json['id'] as int,
    json['name'] as String,
    json['price'] as num,
    json['description'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
    };
