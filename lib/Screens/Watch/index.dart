import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uas/Helpers/Models/Video.dart';
import 'package:flutter_uas/Helpers/Models/WatchMovie.dart';
import 'package:flutter_uas/Screens/Favorites/index.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_uas/Helpers/Constants/API_Key.dart';
import 'package:flutter_uas/Helpers/Models/TopShows.dart';
import 'package:flutter_uas/Helpers/Constants/myColors.dart';
import 'package:flutter_uas/Helpers/Models/Poster.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_uas/Helpers/Models/ShowInfo.dart';
import 'package:provider/provider.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:better_player/better_player.dart';

class Watch extends StatefulWidget {
  @override
  _WatchState createState() => _WatchState();
}

class _WatchState extends State<Watch> {
  var show = Get.arguments; // Object
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerConfiguration _betterPlayerConfiguration;

  final db = FirebaseFirestore.instance;

  WatchMovie movie = WatchMovie(
    imdbId: '',
    seasonNumber: null,
    episodeNumber: null,
  );

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    await getWatchUrl();
    youtubePlayer();
    setState(() {
      isLoading = false;
    });
  }

  void youtubePlayer() {
    String videoUrl = getWatchUrl();
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      autoPlay: true,
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, videoUrl,
        drmConfiguration: BetterPlayerDrmConfiguration(
            drmType: BetterPlayerDrmType.token, token: "Bearer=token"));
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  String getWatchUrl() {
    String url = '';
    if (movie.seasonNumber == null || movie.episodeNumber == null) {
      // Movie
      url = 'https://2embed.org/embed/movie?imdb=${show.Id}';
    } else {
      // TV Show
      url =
          'https://2embed.org/embed/series?imdb=${show.Id}&s=${movie.seasonNumber}&e=${movie.episodeNumber}';
    }
    return url;
  }

  Widget youtubePlayerWidget() {
    return Center(
      child: Text('https://2embed.org/embed/movie?imdb=${show.Id}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: db
            .collection("Users-Favorites")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("items")
            .where('id', isEqualTo: show.Id)
            .snapshots(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: greyBG,
            body: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText(
                                    show.Title,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                  Divider(
                                    color: Colors.white24,
                                    endIndent: 35,
                                    thickness: 1,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  youtubePlayerWidget(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    color: Colors.white24,
                                    endIndent: 35,
                                    thickness: 1,
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
          );
        });
  }
}
