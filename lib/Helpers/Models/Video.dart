class Video {
  final String VideoId;
  final String VideoURL;

  Video({required this.VideoId, required this.VideoURL});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
        VideoId: json['videoId'].toString(),
        VideoURL: json['videoUrl'].toString());
  }
}
