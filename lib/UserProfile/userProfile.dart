import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new


class sellerShopTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? dname = FirebaseAuth.instance.currentUser!.displayName;
    String? email = FirebaseAuth.instance.currentUser!.email;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app_outlined),color: Colors.black,
              onPressed: (){
                Navigator.pushNamed(context, '/');
                FirebaseAuth.instance.signOut();
              },
            )
          ],
        ),
        body: ListView(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag:
                'https://images.unsplash.com/photo-1598369685311-a22ca3406009?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1234&q=80',
                child: Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(62.5),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1598369685311-a22ca3406009?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1234&q=80'))),
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                dname.toString() ,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              Text(
                email.toString(),
                style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Text(
                    //       '24K',
                    //       style: TextStyle(
                    //           fontFamily: 'Montserrat',
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //     SizedBox(height: 5.0),
                    //     Text(
                    //       'FOLLOWERS',
                    //       style: TextStyle(
                    //           fontFamily: 'Montserrat', color: Colors.grey),
                    //     )
                    //   ],
                    // ),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Text(
                    //       '31',
                    //       style: TextStyle(
                    //           fontFamily: 'Montserrat',
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //     SizedBox(height: 5.0),
                    //     Text(
                    //       'FOLLOWING',
                    //       style: TextStyle(
                    //           fontFamily: 'Montserrat', color: Colors.grey),
                    //     ),
                    //   ],
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Text(
                        //   '21',
                        //   style: TextStyle(
                        //       fontFamily: 'Montserrat',
                        //       fontWeight: FontWeight.bold),
                        // ),
                        SizedBox(height: 5.0),
                        Text(
                          'LISTINGS',
                          style: TextStyle(
                              fontFamily: 'Montserrat', color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
              ),
              buildImages(),
              buildInfoDetail(),
              buildImages(),
              buildInfoDetail(),
            ],
          )
        ]));
  }
}

  Widget buildImages() {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: Container(
          height: 200.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1576797371181-97b48d7f6550?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1620&q=80'),
                  fit: BoxFit.cover))),
    );
  }

  Widget buildInfoDetail() {
    return Padding(
      padding:
          EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Spanish Text Books',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 15.0),
              ),
              SizedBox(height: 7.0),
              Row(
                children: <Widget>[
                  Text(
                    'John Smith',
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontFamily: 'Montserrat',
                        fontSize: 11.0),
                  ),
                  SizedBox(width: 4.0),
                  Icon(
                    Icons.timer,
                    size: 4.0,
                    color: Colors.black,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    'University of Florida',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontFamily: 'Montserrat',
                        fontSize: 11.0),
                  )
                ],
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 7.0),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 20.0,
                  width: 20.0,
                  child: Image.network(
                      'https://github.com/rajayogan/flutterui-minimalprofilepage/blob/master/assets/navarrow.png?raw=true'),
                ),
              ),
              SizedBox(width: 7.0),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 20.0,
                  width: 20.0,
                  child: Image.network(
                      'https://github.com/rajayogan/flutterui-minimalprofilepage/blob/master/assets/speechbubble.png?raw=true'),
                ),
              ),
              SizedBox(width: 7.0),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 22.0,
                  width: 22.0,
                  child: Image.network(
                      'https://github.com/rajayogan/flutterui-minimalprofilepage/blob/master/assets/fav.png?raw=true'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
