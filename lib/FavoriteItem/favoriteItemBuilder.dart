import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_shopping_v1/models/favoriteModel.dart';
import 'package:student_shopping_v1/pages/itemDetailPage.dart';

class FavoriteProducts extends StatefulWidget {

  final product_detail_name;
  final product_detail_new_price;
  final product_detail_picture;
  final product_detail_description;
  final product_categoryId;

  FavoriteProducts({
    this.product_detail_name,
    this.product_detail_new_price,
    this.product_detail_picture,
    this.product_detail_description,
    this.product_categoryId,
  });

  @override
  _FavoriteProductsState createState() => _FavoriteProductsState();
}

class _FavoriteProductsState extends State<FavoriteProducts> {
  @override
  Widget build(BuildContext context) {
    var favoriteList = context.watch<FavoriteModel>();
    return new ListView.builder(
      itemCount: favoriteList.items.length,
      // itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index){
          return Single_Favorite_Product(
            cart_prod_name: favoriteList.items[index].name,
            cart_prod_price: favoriteList.items[index].price,
         //   cart_prod_picture: favoriteList.items[index].,
            cart_prod_description: favoriteList.items[index].description,
            cart_prod_id: favoriteList.items[index].id,
            // cart_prod_name: data[index]['name'],
            // cart_prod_price: data[index]['price'],
            // cart_prod_picture: data[index]['imageURL'],
            // cart_prod_description: data[index]['description'],
            // cart_prod_id: data[index]['id'],
          );
        });
  }
}
class Single_Favorite_Product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_id;
  final cart_prod_description;

  Single_Favorite_Product({
    this.cart_prod_name,
    this.cart_prod_picture,
    this.cart_prod_price,
    this.cart_prod_id,
    this.cart_prod_description

  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new ItemDetails(
              cart_prod_name,
              cart_prod_price,
              cart_prod_picture,
              cart_prod_description,
              cart_prod_id,
            ))),
        child: ListTile(
          //=======LEADING SECTION=========
          leading: new Image.network(cart_prod_picture,width: 80.0,height: 80.0,),
          //============TITLE SECTION============
          title: new Text(cart_prod_name),
          //SUBTITLE SECTION=============
          subtitle: new Column(
            children: <Widget>[
              // ROW INSIDE THE COLUMN
              new Row(
                children: <Widget>[
//          THIS SECTION IS FOR THE SIZE OF THE PRODUCT
//                 Padding(
//                   padding: const EdgeInsets.all(0.0),
//                   child: new Text("Size:"),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: new Text(cart_prod_qty.toString(), style: TextStyle(color:Colors.black),),
//                 ),
// //              =============This section is for the product color==============
//                 new Padding(padding: const EdgeInsets.fromLTRB(10.0, 8.0, 8.0, 8.0),
//                   child: new Text("Qty:"),),
//                 Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: new Text(cart_prod_qty.toString(), style: TextStyle(color:Colors.black),),
//                 ),
                  new Padding(padding: const EdgeInsets.fromLTRB(10.0, 8.0, 8.0, 8.0),
                    child: new Text("Price:"),),
                  Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text("\$$cart_prod_price", style:TextStyle(color: Colors.black),)
                  ),
                ],
              ),
//        ===============THIS SECTION IS FOR THE PRODUCT PRICE ====================
            ],
          ),
        ),
      ),
    );
  }
}
