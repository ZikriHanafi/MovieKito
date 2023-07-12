import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

List<TopShows> myFav = [];

class TopShows extends ChangeNotifier {
  final String? Id;
  final String? FullTitle;
  final String? Image;
  final String? IMDbRating;
  final String? Rank;
  final String? Title;
  final String? Year;
  final String? Crew;
  final String? IMDbRatingCount;
  bool isFav;

  TopShows(
      [this.Id,
      this.FullTitle,
      this.Image,
      this.IMDbRating,
      this.Rank,
      this.Title,
      this.Year,
      this.Crew,
      this.IMDbRatingCount,
      this.isFav = false]);

  factory TopShows.fromJson(Map<String, dynamic> json) {
    return TopShows(
      json['id'].toString(),
      json['fullTitle'].toString(),
      json['image'].toString(),
      json['imDbRating'].toString(),
      json['rank'].toString(),
      json['title'].toString(),
      json['year'].toString(),
      json['crew'].toString(),
      json['imDbRatingCount'].toString(),
    );
  }

  Future addToFav(TopShows show) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("Users-Favorites");
    return collectionRef
        .doc(currentUser!.uid)
        .collection("items")
        .doc(show.Id)
        .set({
      "id": show.Id,
      "fullTitle": show.FullTitle,
      "image": show.Image,
      "imDbRating": show.IMDbRating,
      "rank": show.Rank,
      "title": show.Title,
      "year": show.Year,
      "crew": show.Crew,
      "imDbRatingCount": show.IMDbRatingCount,
    });
  }

  Future delFromFav(TopShows show) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("Users-Favorites");
    return collectionRef
        .doc(currentUser!.uid)
        .collection("items")
        .doc(show.Id)
        .delete();
  }

  void addFav(TopShows show) {
    isFav = !isFav;
    myFav.add(show);
  }

  void removeFav(TopShows show) {
    isFav = !isFav;
    myFav.remove(show);
  }

  void updateFav(TopShows show, bool addRemove) {
    if (addRemove) {
      // true // add
      show.addToFav(show);
    } else {
      // false // remove
      show.delFromFav(show);
    }
    notifyListeners();
  }
}
