class WatchMovie {
  final String imdbId;
  final int? seasonNumber;
  final int? episodeNumber;

  WatchMovie({
    required this.imdbId,
    this.seasonNumber,
    this.episodeNumber,
  });

  String getWatchUrl() {
    String url = '';

    if (seasonNumber == null || episodeNumber == null) {
      // Movie
      url = 'https://2embed.org/embed/movie?imdb=$imdbId';
    } else {
      // TV Show
      url =
          'https://2embed.org/embed/series?imdb=$imdbId&s=$seasonNumber&e=$episodeNumber';
    }

    return url;
  }

  factory WatchMovie.fromJson(Map<String, dynamic> json) {
    return WatchMovie(
      imdbId: json['imdbId'],
      seasonNumber: json['seasonNumber'],
      episodeNumber: json['episodeNumber'],
    );
  }
}
