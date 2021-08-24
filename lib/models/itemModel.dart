import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:typed_data';
part 'itemModel.g.dart';
@JsonSerializable()
class ItemPage{
  List<Item>itemList = [];
  List<Item> get items => itemList;

  ItemPage(List<Item> itemList){
    this.itemList = itemList;
  }
  factory ItemPage.fromJson(Map<String, dynamic> parsedJson) => _$ItemPageFromJson(parsedJson);
  Map<String, dynamic> toJson() => _$ItemPageToJson(this);
}


@JsonSerializable()
class ItemRest{
  Item item ;
  List<int> itemImageList = [];  // list of image ids . this should match the json element name
  @JsonKey(ignore : true)
  List<Uint8List> imageDataList = [];


  ItemRest(Item item, List<int> itemImageList) : item = item {
  //  this.item = item;
    this.itemImageList = itemImageList;
  }
  factory ItemRest.fromJson(Map<String, dynamic> parsedJson) => _$ItemRestFromJson(parsedJson);
  Map<String, dynamic> toJson() => _$ItemRestToJson(this);

}

@JsonSerializable()
class Item {
  int id = 0;
  String name = "";
 // String imageURL = "";
  String description = "";
  num price = 0;

  Item(int id,  String name, num price, String description){
    this.id = id;
  //  this.categoryId = categoryId;
    this.name = name;
    this.price = price;
 //   this.imageURL = imageURL;
    this.description = description;
  }


  factory Item.fromJson(Map<String, dynamic> parsedJson) => _$ItemFromJson(parsedJson);
  Map<String, dynamic> toJson() => _$ItemToJson(this);

  @override
  bool operator ==(other) {
    if (other is Item) {
      return other.id == id;
    } else {
      return false;
    }
  }
}
class ItemModel extends ChangeNotifier{
  List <Item> itemList = [];
}





