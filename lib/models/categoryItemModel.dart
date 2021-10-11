import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import '../models/itemModel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
part 'categoryItemModel.g.dart';

const String BASE_URI = 'http://localhost:8080/';
const String CATEGORY_ITEMS_URL = '${BASE_URI}categories/';  // TODO -  call the CategoryItem service when it is built
const String ITEMS_IMAGES_URL = '${BASE_URI}itemImages/';  // append id of image to fetch


@JsonSerializable(explicitToJson: true)
class CategoryItemModel extends ChangeNotifier {
  /// Internal, private state of the cart. Stores the ids of each item.
  int categoryId = 0;
  List<ItemRest> categoryItems = [];
  /// List of items in the cart.
  List<ItemRest> get items => categoryItems;
  //Add categoryItem



  factory CategoryItemModel.fromJson(Map<String, dynamic> parsedJson) =>
      _$CategoryItemModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$CategoryItemModelToJson(this);

// Todo -- Move below to service class

  Future<void> _getItems() async {
    categoryItems.clear();
    await getItemRestList();
    await get1stImageForItemIfAvailable();
    notifyListeners();
  }

  Future<int?> _postItem(Item itm) async {
    int? itmId = await _postItemSingle(itm);
    //notifyListeners();
    return itmId;
  }


  Future<int?> _postItemSingle(Item itm) async {
    Map<String, dynamic> data;

    var url = Uri.parse(CATEGORY_ITEMS_URL +
        '${categoryId}/items'); // TODO -  call the recentItem service when it is built
    var tmpObj =  json.encode(itm.toJson());
    http.Response response = await http.post(url
        , headers: {"Content-Type": "application/json"}
        , body: tmpObj);
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
  //    var item = data['content'];
      var id = data['id'];
      return id;
  //    Item itm = Item.fromJson(item);
    } else {
      print(response.statusCode);
    }

  }

  Future<void> getItemRestList() async {
    Map<String, dynamic> data;

    var url = Uri.parse(CATEGORY_ITEMS_URL+'${categoryId}/items'); // TODO -  call the recentItem service when it is built
    http.Response response = await http.get(
        url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      var items = data['content'];
      for (int i = 0; i < items.length; i++) {
        ItemRest itm = ItemRest.fromJson(items[i]);
        categoryItems.add(itm);
        // for (int imgId in itm.itemImageList) {
        //   var url = Uri.parse(
        //       'http://localhost:8080/categories/1/items'); // TODO -  call the recentItem service when it is built
        // }
      }
 //     notifyListeners();
      print(categoryItems);
    } else {
      print(response.statusCode);
    }
  }

  Future<void> get1stImageForItemIfAvailable() async {
    if (categoryItems.isEmpty) return;

    Uint8List data = new Uint8List(0) ;
    for (int i = 0; i < categoryItems.length; i++) {
      if (categoryItems[i].itemImageList.isNotEmpty) {
        String urlString = ITEMS_IMAGES_URL +
            (categoryItems[i].itemImageList[0]).toString();
        var url = Uri.parse(urlString);
        http.Response response = await http.get(
            url, headers: {"Accept": "application/json"});
        if (response.statusCode == 200) {
          data = response.bodyBytes;
        }
        print(categoryItems);
      } else {   // Add default - no image
        data = (await rootBundle.load('assets/images/no-picture-available-icon.png'))
            .buffer
            .asUint8List();
      }
      categoryItems[i].imageDataList.add(data);
    }
  }
  void getCategoryItems (int categoryId) {
    this.categoryId = categoryId;
    var initFuture = _getItems();
    initFuture.then((voidValue) {
//      notifyListeners();
    });
  }


  int? addCategoryItem (int categoryId, Item itm)    {
    this.categoryId = categoryId;
    var itmId =  _postItem(itm).then((value) {  return value?.toInt();}) ;
  }

  CategoryItemModel() {
  }

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(ItemRest item) {
    categoryItems.add(item);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
  //  notifyListeners();
  }

  void remove(ItemRest item) {
    categoryItems.remove(item);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
 //   notifyListeners();
  }
}


// Handle one Page of Items
@JsonSerializable(explicitToJson: true)
class CategoryItemPage {
  List<Item> categoryItemList = [];
  List<Item> get categoryItems => categoryItemList;

  CategoryItemPage(List<Item> categoryItemList){
    this.categoryItemList = categoryItemList;
  }
  factory CategoryItemPage.fromJson(Map<String, dynamic> parsedJson) => _$CategoryItemPageFromJson(parsedJson);
  Map<String, dynamic> toJson() => _$CategoryItemPageToJson(this);
}