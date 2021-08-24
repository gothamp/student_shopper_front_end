import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:student_shopping_v1/Widgets/FavoriteWidget.dart';

class ItemDetails extends StatefulWidget {
  String item_name = '';
  num item_price =0.0;
  Uint8List item_picture = new  Uint8List(0) ;
  String item_description = '';
  int item_Id =0;

  ItemDetails(
    item_detail_name ,
    item_detail_price,
    item_detail_picture ,
    item_description,
    item_Id,
  ) {
    this.item_name = item_detail_name;
    this.item_price = item_detail_price;
    this.item_picture = item_detail_picture;
    this.item_description = item_description;
    this.item_Id = item_Id;
  }


  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    var isAlwaysTrue = true;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.grey[800], size: 27),
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                  boxShadow: [BoxShadow(spreadRadius: 0, blurRadius: 19, offset: Offset(0, 4), color: Colors.grey)],
                  image: DecorationImage(image: MemoryImage(widget.item_picture), fit: BoxFit.cover),
                 //     image: NetworkImage(widget.item_detail_picture),fit: BoxFit.cover)
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 15, top: 15),
                child: Text(widget.item_name,style: TextStyle(fontSize: 19, color: Colors.grey[700]),textAlign: TextAlign.left,)
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 15, top: 15),
                  child: Text('\$${widget.item_price}',style: TextStyle(fontSize: 19, color: Colors.grey[700]),textAlign: TextAlign.left,)
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 15, top: 15),
                  child: Text('Description',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[700]),textAlign: TextAlign.left,)
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 15, top: 15),
                  child: Text(widget.item_description,style: TextStyle(fontSize: 15, color: Colors.grey[700]),textAlign: TextAlign.left,)
              ),
            ],
          ),
        ),
      ),
bottomNavigationBar: Container(
  width: MediaQuery.of(context).size.width,
  height: 100,
  child: Container(
    margin: EdgeInsets.only(left: 10, right:10, bottom: 10),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Text(
            "Send Message",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
        InkWell(
          //todo: update list
          child: Container(
            child: FavoriteWidget(
              item_name: widget.item_name,
              item_id: widget.item_Id,  
              item_picture: widget.item_picture,
              item_price: widget.item_price,   
              item_desc: widget.item_description,
            ),
          ),
        ),
      ],
    ),
  ),
),
    );
  }
}

