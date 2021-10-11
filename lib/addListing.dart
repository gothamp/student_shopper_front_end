import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:student_shopping_v1/models/categoryItemModel.dart';

import 'models/itemModel.dart';

class AddListing extends StatefulWidget {
  @override
  _AddListingState createState() => _AddListingState();
}

class _AddListingState extends State<AddListing> {



  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  String _value = "1";
  int newItemId = 0;
  //late String imageUrl;
  late Future<File> imageFile;
  File? _image1;
  File? _image2;
  File? _image3;

  String userEmail = "";
  late Map data;
  late File file;

  // ImagePicker _imagePicker = new ImagePicker();
  //
  // _imgFromCamera() async {
  //   XFile? image = await _imagePicker.pickImage(
  //       source: ImageSource.camera, imageQuality: 50
  //   );
  //
  //   setState(() {
  //     _image = image;
  //   });
  // }
  //
  // _imgFromGallery() async {
  //   XFile image = await  _imagePicker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 50
  //   );
  //
  //   setState(() {
  //     _image = image;
  //   });
  // }



  Future getImage(int type) async {
    PickedFile pickedImage = (await ImagePicker().getImage(
        source: type == 1 ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50))!;
    return pickedImage;
  }

  // PickedFile? imageFile;
  //
  // _openGallery(BuildContext context) async {
  //   var picture = await ImagePicker().getImage(source: ImageSource.gallery);
  //   this.setState(() {
  //     imageFile = picture;
  //   });
  //   Navigator.of(context).pop();
  //
  // }
  //
  // _openCamera(BuildContext context) async {
  //   var picture = await ImagePicker().getImage(source: ImageSource.camera);
  //   this.setState(() {
  //     imageFile = picture;
  //   });
  //   Navigator.of(context).pop();
  // }

  // Future<void> _showChoiceDialog(BuildContext context){
  //   return showDialog(context: context, builder: (BuildContext context){
  //     return AlertDialog(
  //       title: Text("Make a Choice!"),
  //       content: SingleChildScrollView(
  //         child: ListBody(
  //           children: [
  //             GestureDetector(
  //               child: Text("Gallery"),
  //               onTap: (){
  //                 _openGallery(context);
  //               },
  //             ),
  //             Padding(padding: EdgeInsets.all(8.0)),
  //             GestureDetector(
  //               child: Text("Camera"),
  //               onTap: (){
  //                 _openCamera(context);
  //               },
  //             ),
  //           ],
  //         )
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {

 //   var recentList = context.watch<CategoryItemModel>();
    return Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          iconTheme: new IconThemeData(color: Colors.grey[800], size: 27),
          backgroundColor: Colors.grey[300],
          elevation: 0,
          // title: Center(
          title: Text(
            'Add Listing',
            style: TextStyle(color: Colors.black),
          ),
          // ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(primary: Colors.grey.withOpacity(0.5),
                          side: BorderSide(color: Colors.red, width: 5),),
                        onPressed: () async {
                          _selectImage(
                              ImagePicker()
                                  .pickImage(source: ImageSource.gallery),
                              1);
                          // _showChoiceDialog(context);
                        },
                        child: _displayChild1()),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(primary: Colors.grey.withOpacity(0.5),
                          side: BorderSide(color: Colors.red, width: 5),),
                        onPressed: () async {
                          _selectImage(
                              ImagePicker()
                                  .pickImage(source: ImageSource.gallery),
                              2);
                        },
                        child: _displayChild2()),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(primary: Colors.grey.withOpacity(0.5),
                          side: BorderSide(color: Colors.red, width: 5),),
                        onPressed: () async {
                          _selectImage(
                              ImagePicker()
                                  .pickImage(source: ImageSource.gallery),
                              3);
                        },
                        child: _displayChild3()),
                  ),
                ),
              ],
            ),
            // Text(
            //   'Enter the product name with 10 characters maximum',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(color: Colors.red, fontSize: 12),
            // ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: itemNameController,
                decoration: InputDecoration(
                  hintText: 'Item Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                controller: itemDescriptionController,
                // initialValue: '1',
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                // initialValue: '0.00',
                controller: productPriceController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    try {
                      final text = newValue.text;
                      if (text.isNotEmpty) double.parse(text);
                      return newValue;
                    } catch (e) {}
                    return oldValue;
                  }),
                ],
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),

                decoration: InputDecoration(
                  hintText: 'Price',
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: DropdownButton(
                      value: _value,
                      items: [
                        DropdownMenuItem(
                          child: Text("Text Book"),
                          value: "1",
                        ),
                        DropdownMenuItem(
                            child: Text("Clothes"), value: "2"),
                        DropdownMenuItem(
                          child: Text("Sporting Goods"),
                          value: "3",
                        ),
                        DropdownMenuItem(child: Text("Misc."), value: "4")
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value.toString();
                        });
                      }),
                )),

            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
              child: Text('Add Product'),
              onPressed: () {
                var  itemId  =  addNewItemToDB(
                  context,
                    itemNameController.text,
                    itemDescriptionController.text,
                    productPriceController.text,  
                    _value);
                if (itemId != null) {
                  if (_image1 != null)
                    uploadItemImageToDB(_image1!, itemId.toInt());

                  if (_image2 != null) {
                    uploadItemImageToDB(_image2!, itemId.toInt());
                  }

                  if(_image3 != null){
                    uploadItemImageToDB(_image3!, 1);
                  }
                }
              },

            )
          ]),
        ));
  }

  void _selectImage(Future<XFile?> pickImage, int imageNumber) async {
    XFile? tempImg1 = await pickImage;
    File tempImg = File(tempImg1!.path);
    switch (imageNumber) {
      case 1:
        setState(() {
          _image1 = tempImg;
        });
        break;
      case 2:
        setState(() {
          _image2 = tempImg;
        });
        break;
      case 3:
        setState(() {
          _image3 = tempImg;
        });
        break;
    }
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 50.0, 14.0, 50.0),
        child: new Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Image.file(
        _image1!,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild2() {
    if (_image2 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 50.0, 14.0, 50.0),
        child: new Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Image.file(
        _image2!,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild3() {
    if (_image3 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 50.0, 14.0, 50.0),
        child: new Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Image.file(
        _image3!,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  int?  addNewItemToDB   (
      BuildContext context
      , String name
      , String description
      , String price
      , String categoryId)   {

    var item =  Item(int.parse(categoryId), name, num.parse(price), description);
    var itemId =  Provider.of<CategoryItemModel>(context, listen: false)
            .addCategoryItem(int.parse(categoryId), item);
    return itemId;
    // return  http.post(
    //   Uri.parse('http://localhost:8080/categories/$categoryId/items'),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode({
    //     'name': name,
    //     'description': description,
    //     'price': num.parse(price),
    //   }),
    // );
  }

  uploadItemImageToDB(File imageFile, int itemId) async {
    var stream  = new http.ByteStream(imageFile.openRead()); stream.cast();
    var length = await imageFile.length();

    var uri = Uri.parse('http://localhost:8080/items/$itemId/itemImages');

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('itemImage', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  getNewlyUploadedItemIdFromDB(String name, String description, String price, String categoryId){

  }

  // openDBConnection() async {
  //   var conn = new SqlConnection(host: 'localhost', db: 'circleshopper', password: 'password123', user: 'root');
  //   newItemId = (await conn.execute("SELECT last_insert_rowid()")) as int;
  //   print(newItemId);
  // }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) {
      return;
    }
    final path = result.files.single.path;
    setState(() {
      file = File(path!);
    });
  }
}
