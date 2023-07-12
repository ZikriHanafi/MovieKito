import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uas/Screens/Home/index.dart';
import 'package:flutter_uas/Screens/Login/index.dart';
import 'package:flutter_uas/Splash.dart';
import 'package:flutter_uas/firebase_options.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends GetxController {
  GoogleSignIn googleSignIn = GoogleSignIn();
  static AuthService instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() async {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("login page");
      Get.off(() => LoginPage());
    } else {
      Get.off(() => Splash());
    }
    ;
  }

  signInWithGoogle() async {
    if (DefaultFirebaseOptions.currentPlatform != DefaultFirebaseOptions.web) {
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: <String>["email"]).signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      Get.off(() => Splash(),
          duration: Duration(milliseconds: 1000), transition: Transition.zoom);

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
          clientId:
              "849598015198-gggi5udjvommtu2brpr72jj0n9dkt9fd.apps.googleusercontent.com",
          scopes: <String>["email"]).signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      Get.off(() => Splash(),
          duration: Duration(milliseconds: 1000), transition: Transition.zoom);

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  signOut() async {
    final googleCurrentUser = auth.currentUser;
    Get.off(() => LoginPage(),
        duration: Duration(milliseconds: 1000), transition: Transition.zoom);
    if (googleCurrentUser != null) {
      await googleSignIn.signOut();
      await auth.signOut();
    }
  }
}
