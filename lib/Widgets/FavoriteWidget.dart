import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:student_shopping_v1/models/favoriteModel.dart';
import 'package:provider/provider.dart';
import 'package:student_shopping_v1/models/itemModel.dart';

class FavoriteWidget extends StatefulWidget {
  final item_name;
  final item_price;
  final item_picture;
  final item_id;
  final item_desc;

  FavoriteWidget({
    this.item_name,
    this.item_price,
    this.item_picture,
    this.item_id,
    this.item_desc
  });

  @override
  _FavoriteWidgetState createState() =>
      _FavoriteWidgetState(item_name, item_price, item_picture, item_id,item_desc);
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  String product_name;
  double product_price;
  Uint8List product_picture;
  int product_id;
  String product_desc;

  _FavoriteWidgetState(
      this.product_name, this.product_price, this.product_picture, this.product_id, this.product_desc);

  void _toggleFavorite(var isInFavoritesList, Item item) {

    setState(() {
        var favoriteList = context.read<FavoriteModel>();

        if(!isInFavoritesList){
          favoriteList.add(item);
        } else {
          favoriteList.remove(item);
        }
      isInFavoritesList ? isInFavoritesList = false : isInFavoritesList = true;
    });
  }

  bool inFavorites(var favorite, Item item){
    bool isFavorite = favorite.items.contains(item);
    return isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    var item = new Item(product_id,product_name,product_price,product_desc);


    var isInFavoritesList = context.select<FavoriteModel, bool>(
          (favorite) => inFavorites(favorite, item)
    );
    return Padding(
        padding: const EdgeInsets.fromLTRB(1.0, 2.0, 10.0, 4.0),
        child: Container(
          child: new IconButton(
              icon: Icon(isInFavoritesList ? Icons.favorite : Icons.favorite_border),
              color: Colors.black,
              onPressed: () {
                _toggleFavorite(isInFavoritesList, item);
              }),
        ));
  }
}
