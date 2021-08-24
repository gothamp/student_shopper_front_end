import 'package:flutter/foundation.dart';
import '../models/itemModel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';




class FavoriteModel extends ChangeNotifier {
  /// Internal, private state of the cart. Stores the ids of each item.
  List<Item> _favoriteItems = [];
  /// List of items in the cart.
  List<Item> get items => _favoriteItems;



  Future<void> init() async {
    List data;
    var url = Uri.parse('http://localhost:8080/profiles/1/favorites');
    http.Response response = await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      // data.map<Item>((json) => Item.fromJson(json)).toList();
      data = jsonDecode(response.body) as List;
      _favoriteItems = data.map((itm) => new Item.fromJson(itm)).toList();
      print(_favoriteItems);
    } else {
      print (response.statusCode);
    }
  }

  FavoriteModel(){
    var initFuture = init();
    initFuture.then((voidValue) {
      // state = HomeScreenModelState.initialized;
      notifyListeners();
    });
  }
  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item) {
    _favoriteItems.add(item);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  void remove(Item item) {
    _favoriteItems.remove(item);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }
}

