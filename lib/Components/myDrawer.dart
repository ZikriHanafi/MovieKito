import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uas/Helpers/Models/Authentication.dart';
import 'package:flutter_uas/Screens/Login/index.dart';
import 'package:get/get.dart';
import 'package:flutter_uas/Helpers/Constants/myColors.dart';
import 'package:flutter_uas/Screens/Favorites/index.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple, Colors.pink],
          ),
        ),
        child: ListView(
          children: [
            Container(
              height: 120,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 28),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  FirebaseAuth.instance.currentUser!.photoURL!),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          )),
                      SizedBox(
                        width: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  FirebaseAuth
                                      .instance.currentUser!.displayName!,
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  FirebaseAuth.instance.currentUser!.email!,
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
              endIndent: 15,
              indent: 15,
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.heart_fill,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                'Favorit',
                style: TextStyle(
                  color: white,
                  fontSize: 18,
                ),
              ),
              onTap: () async {
                await Get.to(
                  () => Favorites(),
                  duration: Duration(milliseconds: 850),
                  transition: Transition.leftToRightWithFade,
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                'Log Out',
                style: TextStyle(
                  color: white,
                  fontSize: 18,
                ),
              ),
              onTap: () async {
                AuthService.instance.signOut();
              },
            ),
            Row(
              children: [
                Text(
                  "Designed by Taufik, Zikri and Bagas",
                  style: TextStyle(
                    color: white,
                    fontSize: 15,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

/*Drawer myDrawer = Drawer(
  child: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.deepPurple, Colors.pink],
      ),
    ),
    child: ListView(
      children: [
        Container(
          height: 120,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 28),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              FirebaseAuth.instance.currentUser!.photoURL!),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      )),
                  SizedBox(
                    width: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              FirebaseAuth.instance.currentUser!.displayName!,
                              style: TextStyle(
                                color: white,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              FirebaseAuth.instance.currentUser!.email!,
                              style: TextStyle(
                                color: white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.white,
          endIndent: 15,
          indent: 15,
        ),
        ListTile(
          leading: Icon(
            CupertinoIcons.heart_fill,
            color: Colors.white,
            size: 30,
          ),
          title: Text(
            'Favorit',
            style: TextStyle(
              color: white,
              fontSize: 18,
            ),
          ),
          onTap: () async {
            await Get.to(
              () => Favorites(),
              duration: Duration(milliseconds: 850),
              transition: Transition.leftToRightWithFade,
            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 30,
          ),
          title: Text(
            'Log Out',
            style: TextStyle(
              color: white,
              fontSize: 18,
            ),
          ),
          onTap: () async {
            AuthService.instance.signOut();
            
          },
        ),
        Row(
          children: [
            Text(
              "Designed by Taufik, Zikri and Bagas",
              style: TextStyle(
                color: white,
                fontSize: 15,
              ),
            )
          ],
        )
      ],
    ),
  ),
);
*/