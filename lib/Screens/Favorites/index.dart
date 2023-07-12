import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_uas/Components/AppBar.dart';
import 'package:flutter_uas/Helpers/Models/TopShows.dart';
import 'package:flutter_uas/Helpers/Constants/myColors.dart';
import 'package:flutter_uas/Screens/Details/index.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  bool isLoading = false;
  final db = FirebaseFirestore.instance;

  TopShows _topShows = TopShows();

  var list = [];

  Widget ShowContainer() {
    return StreamBuilder<QuerySnapshot>(
        stream: db
            .collection("Users-Favorites")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("items")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.separated(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                Map<String, dynamic> mapJson =
                    document.data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () async {
                    await Get.to(() => Details(),
                        arguments: TopShows.fromJson(mapJson),
                        duration: Duration(milliseconds: 700),
                        transition: Transition.leftToRightWithFade);
                    setState(() {});
                  },
                  child: Container(
                    color: greyBG,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 185,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Image(
                                    image: NetworkImage(document.get('image')),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        document.get('title'),
                                        style: TextStyle(
                                            fontSize: 20, color: white),
                                      ),
                                      Text(
                                        document.get('year'),
                                        style: TextStyle(
                                            fontSize: 18, color: white),
                                      ),
                                      Text(
                                        document.get('crew'),
                                        style: TextStyle(
                                            fontSize: 15, color: white),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: yellow,
                                            size: 23,
                                          ),
                                          document
                                                  .get('imDbRating')
                                                  .toString()
                                                  .isNotEmpty
                                              ? Text(
                                                  ' ' +
                                                      document
                                                          .get('imDbRating'),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: white),
                                                )
                                              : Text(
                                                  ' TBA',
                                                  style: TextStyle(
                                                    color: white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.white54,
                  indent: 8,
                  endIndent: 8,
                );
              },
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBG,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(54),
        child: NamedAppBar("Favorit Anda"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: ShowContainer(),
            ),
    );
  }
}
