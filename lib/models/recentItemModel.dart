import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import '../models/itemModel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
part 'recentItemModel.g.dart';

const String BASE_URI = 'http://localhost:8080/';
const String RECENT_ITEMS_URL = '${BASE_URI}categories/1/items';  // TODO -  call the recentItem service when it is built
const String ITEMS_IMAGES_URL = '${BASE_URI}itemImages/';  // append id of image to fetch

// Handle one Page of Items
@JsonSerializable(explicitToJson: true)
class RecentItemPage {
  List<Item> recentItemList = [];
  List<Item> get recentItems => recentItemList;

  RecentItemPage(List<Item> recentItemList){
    this.recentItemList = recentItemList;
  }
  factory RecentItemPage.fromJson(Map<String, dynamic> parsedJson) => _$RecentItemPageFromJson(parsedJson);
  Map<String, dynamic> toJson() => _$RecentItemPageToJson(this);
}


@JsonSerializable(explicitToJson: true)
class RecentItemModel extends ChangeNotifier {
  /// Internal, private state of the cart. Stores the ids of each item.
  List<ItemRest> _recentItems = [];

  /// List of items in the cart.
  List<ItemRest> get items => _recentItems;

  factory RecentItemModel.fromJson(Map<String, dynamic> parsedJson) =>
      _$RecentItemModelFromJson(parsedJson);

  Map<String, dynamic> toJson() => _$RecentItemModelToJson(this);

  Future<void> init() async {
    await getItemRestList();
    await add1stImageToItemIfAvailable();
  }

  Future<void> getItemRestList() async {
    Map<String, dynamic> data;
    var url = Uri.parse(
        RECENT_ITEMS_URL); // TODO -  call the recentItem service when it is built
    http.Response response = await http.get(
        url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      // data.map<Item>((json) => Item.fromJson(json)).toList();
      data = jsonDecode(response.body);
      var items = data['content'];
      for (int i = 0; i < items.length; i++) {
        ItemRest itm = ItemRest.fromJson(items[i]);
        _recentItems.add(itm);
        // for (int imgId in itm.itemImageList) {
        //   var url = Uri.parse(
        //       'http://localhost:8080/categories/1/items'); // TODO -  call the recentItem service when it is built
        // }
      }
      print(_recentItems);
    } else {
      print(response.statusCode);
    }
  }

  Future<void> add1stImageToItemIfAvailable() async {
    if (_recentItems.isEmpty) return;

    Uint8List data = new Uint8List(0) ;
    for (int i = 0; i < _recentItems.length; i++) {
      if (_recentItems[i].itemImageList.isNotEmpty) {
        String urlString = ITEMS_IMAGES_URL +
            (_recentItems[i].itemImageList[0]).toString();
        var url = Uri.parse(urlString);
        http.Response response = await http.get(
            url, headers: {"Accept": "application/json"});
        if (response.statusCode == 200) {
          data = response.bodyBytes;
        }
        print(_recentItems);
      } else {   // Add default - no image
        data = (await rootBundle.load('assets/images/no-picture-available-icon.png'))
            .buffer
            .asUint8List();
      }
      _recentItems[i].imageDataList.add(data);
    }
  }


  RecentItemModel() {
      var initFuture = init();
      initFuture.then((voidValue) {
        // state = HomeScreenModelState.initialized;
        notifyListeners();
      });
  }

    /// Adds [item] to cart. This is the only way to modify the cart from outside.
    void add(ItemRest item) {
      _recentItems.add(item);
      // This line tells [Model] that it should rebuild the widgets that
      // depend on it.
      notifyListeners();
    }

    void remove(ItemRest item) {
      _recentItems.remove(item);
      // Don't forget to tell dependent widgets to rebuild _every time_
      // you change the model.
      notifyListeners();
    }
  }
