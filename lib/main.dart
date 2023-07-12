import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uas/Helpers/Models/Authentication.dart';
import 'package:flutter_uas/Screens/Login/index.dart';
import 'package:flutter_uas/firebase_options.dart';
import 'package:get/get.dart';
import 'package:flutter_uas/Helpers/Models/TopShows.dart';
import 'package:flutter_uas/Screens/Home/index.dart';
import 'package:flutter_uas/Splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthService()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TopShows(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: LoginPage(),
      ),
    );
  }
}
