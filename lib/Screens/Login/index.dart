import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uas/Components/AppBar.dart';
import 'package:flutter_uas/Helpers/Constants/myColors.dart';
import 'package:flutter_uas/Helpers/Models/Authentication.dart';
import 'package:get/get.dart';
import 'package:flutter_uas/Helpers/Models/TopShows.dart';
import 'package:flutter_uas/Screens/Home/index.dart';
import 'package:flutter_uas/Splash.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: greyBG,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(54),
        child: NamedAppBar("Movie Kito"),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: size.height * 0.2,
            bottom: size.height * 0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Movie Kito",
                style: TextStyle(fontSize: 30, color: Colors.white)),
            ElevatedButton(
              onPressed: (() async {
                AuthService.instance.signInWithGoogle();
              }),
              child: Text("Signin With Google"),
              style: ElevatedButton.styleFrom(backgroundColor: deepPurple),
            )
          ],
        ),
      ),
    );
  }
}
