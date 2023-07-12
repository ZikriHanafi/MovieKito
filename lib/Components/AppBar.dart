import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_uas/Helpers/Constants/myColors.dart';
import 'package:flutter_uas/Screens/Favorites/index.dart';

AppBar myAppbar = AppBar(
  title: Text('Movie Kito'),
  centerTitle: true,
  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        // stops: [0.1, 0.5, 0.7, 0.9],
        colors: [Colors.deepPurple, Colors.pink],
      ),
    ),
  ),
  // backgroundColor: deepPurple,
  actions: <Widget>[
    IconButton(
      icon: Icon(
        Icons.favorite,
        color: Colors.white,
      ),
      onPressed: () async {
        await Get.to(
          () => Favorites(),
          duration: Duration(milliseconds: 1100),
          transition: Transition.rightToLeftWithFade,
        );
      },
    )
  ],
);

Widget NamedAppBar(String _title) {
  return AppBar(
    title: Text(_title),
    backgroundColor: deepPurple,
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.pink, Colors.deepPurple],
        ),
      ),
    ),
  );
}
