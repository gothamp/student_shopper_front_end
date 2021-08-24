import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:student_shopping_v1/models/categoryItemModel.dart';
import 'dart:async';
import 'dart:convert';
import '../pages/itemDetailPage.dart';

const String BASE_URI = 'http://localhost:8080/';

const String ITEMS_IMAGES_URL = '${BASE_URI}itemImages/';  // append id of image to fetch

class SpecificCategoryPage extends StatefulWidget {
  final int categoryId;
  SpecificCategoryPage(this.categoryId);

  @override
  _SpecificCategoryPageState createState() => _SpecificCategoryPageState();
}

class _SpecificCategoryPageState extends State<SpecificCategoryPage> {

  // List data = [];
  //
  // Future<String> getData() async {
  //   // const String CATEGORY_ITEMS_URL = '${BASE_URI}categories/${widget.categoryId}/items';
  //   var url = Uri.parse('${BASE_URI}categories/${widget.categoryId}/items');
  //   http.Response response = await http.get(url, headers: {"Accept": "application/json"});
  //   if (response.statusCode == 200) {
  //     data = jsonDecode(response.body) as List;
  //     print(data);
  //   } else {
  //     print (response.statusCode);
  //   }
  //
  //   this.setState(() {
  //   });
  //
  //   throw 'TODO';
  // }
  //
  // @override
  // void initState() {
  //   this.getData();
  // }
  @override
  void initState() {
    super.initState();
    final categoryItemMdl = Provider.of<CategoryItemModel>(context, listen: false).setCategoryId(widget.categoryId);
  }
  @override
  Widget build(BuildContext context) {
    var categoryList = context.watch<CategoryItemModel>();

    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: new IconThemeData(color: Colors.grey[800], size: 27),
      //   backgroundColor: Colors.grey[300],
      //   elevation: .1,
      //   title: Center(
      //     child: Text(
      //       'Student Shopping',
      //       style: TextStyle(color: Colors.black),
      //     ),
      //   ),
      //   actions: [
      //     Container(
      //       margin: EdgeInsets.only(right: 10),
      //       child: Icon(
      //         Icons.search,
      //         color: Colors.grey[800],
      //         size: 27,
      //       ),
      //     ),
      //   ],
      // ),
      body:  SingleChildScrollView (
      child: Column(
        children: [
          AppBar(
            iconTheme: new IconThemeData(color: Colors.grey[800], size: 27),
            backgroundColor: Colors.grey[300],
            elevation: .1,
            title: Center(
            child: Text(
            'Student Shopping',
            style: TextStyle(color: Colors.black),
              ),
            ),
            actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
              Icons.search,
              color: Colors.grey[800],
              size: 27,
            ),
          ),
        ],
      ),
        Container(
            margin: EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height-90,
            child: GridView.builder(
                itemCount: categoryList.items.length ,
                physics: ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,),
                itemBuilder: (BuildContext context, int index) {
                  // padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  return Single_prodz(
                    prod_name: categoryList.items[index].item.name,
                    prod_picture: categoryList.items[index].imageDataList[0],  // TODO display carosel of all images
                    prod_price: categoryList.items[index].item.price,
                    prod_description: categoryList.items[index].item.description,
                    prod_itemId: categoryList.items[index].item.id);
              }
            )
          ),
        ],
      ),
      ),
    );
  }
}

class Single_prodz extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_price;
  final prod_description;
  final prod_itemId;
  Single_prodz({
    this.prod_name,
    this.prod_picture,
    this.prod_price,
    this.prod_description,
    this.prod_itemId,
  });
  @override
  Widget build(BuildContext context) {
    return


      Column(
      children: [
        InkWell(
          onTap: () => Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => new ItemDetails(
                prod_name,
                prod_price,
                prod_picture,
                prod_description,
                prod_itemId,
                //prod_picture ,
              ))),
          child: Container(
            margin: EdgeInsets.only(left: 15),
            width: 150,
            height: 100,
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
                image: DecorationImage(image: MemoryImage(prod_picture), fit: BoxFit.cover),
                color: Colors.white,
                borderRadius: BorderRadius.circular(18)),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          width: 150,
          margin: EdgeInsets.only(top: 5, left: 15),
          height: 30,
          child: Text("\$${prod_price}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        ),
        Container(
          alignment: Alignment.topLeft,
          width: 150,
          margin: EdgeInsets.only(top: 5, left: 15),
          height: 40,
          child: Text("${prod_name}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
