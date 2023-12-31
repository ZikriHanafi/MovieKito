import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uas/Helpers/Models/Authentication.dart';
import 'package:flutter_uas/Screens/Login/index.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter_uas/Helpers/Constants/API_Key.dart';
import 'package:flutter_uas/Helpers/Constants/MyLists.dart';
import 'package:flutter_uas/Screens/Home/index.dart';
import 'Helpers/Models/TopShows.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    print('getData');
    getData();
    print('getData');
    controller = AnimationController(
        duration: Duration(milliseconds: 10000), vsync: this);
    animation = ColorTween(begin: Colors.green, end: Colors.deepPurple)
        .animate(controller!);
    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });

    Timer(Duration(milliseconds: 10000), () {
      Get.off(
        () => HomePage(),
        duration: Duration(milliseconds: 100),
        transition: Transition.fade,
      );
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void getData() async {
    await getTop250Movies();
    await getTop250Series();
    await getTrendingMovies();
    await getTrendingSeries();
  }

  Future<void> getTop250Movies() async {
    String url = "https://imdb-api.com/en/API/Top250Movies/$api_key";
    print(url);

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (this.mounted) {
      setState(() {
        Map data = json.decode(utf8.decode(response.bodyBytes));

        top250Movies =
            (data['items'] as List).map((e) => TopShows.fromJson(e)).toList();
      });
    }
  }

  Future<void> getTop250Series() async {
    String url = "https://imdb-api.com/en/API/Top250TVs/$api_key";
    print(url);

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (this.mounted) {
      setState(() {
        Map data = json.decode(utf8.decode(response.bodyBytes));

        top250Series =
            (data['items'] as List).map((e) => TopShows.fromJson(e)).toList();
      });
    }
  }

  Future<void> getTrendingMovies() async {
    String url = "https://imdb-api.com/en/API/MostPopularMovies/$api_key";

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (this.mounted) {
      setState(() {
        Map data = json.decode(utf8.decode(response.bodyBytes));

        trendingMovies =
            (data['items'] as List).map((e) => TopShows.fromJson(e)).toList();
      });
    }
  }

  Future<void> getTrendingSeries() async {
    String url = "https://imdb-api.com/en/API/MostPopularTVs/$api_key";

    final response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (this.mounted) {
      setState(() {
        Map data = json.decode(utf8.decode(response.bodyBytes));

        trendingSeries =
            (data['items'] as List).map((e) => TopShows.fromJson(e)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation!.value,
      body: Center(
        child: Stack(
          children: [
            Icon(
              CupertinoIcons.tv_circle_fill,
              size: 50,
              color: Colors.white,
            ),
            Positioned(
              right: 95,
              top: 85,
              child: Text(
                'TV',
                style: GoogleFonts.anton(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
