import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_shopping_v1/pages/itemDetailPage.dart';
import 'package:student_shopping_v1/models/recentItemModel.dart';


class RecentItems extends StatefulWidget {
  @override
  _RecentItemsState createState() => _RecentItemsState();
}

class _RecentItemsState extends State<RecentItems> {

  @override
  Widget build(BuildContext context) {
    var recentList = context.watch<RecentItemModel>();

    return Container(
        margin: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        //height: 380,
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
            itemCount: recentList.items.length == null ? 0 : recentList.items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,),
            itemBuilder: (BuildContext context, int index) {
              // padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              return SingleItem(
                  item_name: recentList.items[index].item.name,
                  item_picture: recentList.items[index].imageDataList[0],
                  item_price: recentList.items[index].item.price,
                  item_description: recentList.items[index].item.description,
                  item_id:recentList.items[index].item.id);
            }));
  }
}

class SingleItem extends StatelessWidget {
  final item_name;
  final item_picture;
  final item_price;
  final item_description;
  final item_id;

  SingleItem({
    this.item_name,
    this.item_picture,
    this.item_price,
    this.item_description,
    this.item_id,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => new ItemDetails(
                     item_name,
                     item_price,
                     item_picture,
                     item_description,
                     item_id,
                  ))),
          child: Container(
            margin: EdgeInsets.only(left: 15),
            width: 150,
            height: 100,
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
                image: DecorationImage(image: MemoryImage(item_picture), fit: BoxFit.cover),
                color: Colors.teal,
                borderRadius: BorderRadius.circular(18)),
            child: Container(
              margin: EdgeInsets.only(right: 10, top: 5),
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: 150,
          margin: EdgeInsets.only(top: 5, left: 15),
          height: 30,
          child: Text("\$${item_price}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        ),
        Container(
          alignment: Alignment.topLeft,
          width: 150,
          margin: EdgeInsets.only(top: 0, left: 15),
          height: 30,
          child: Text("${item_name}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
