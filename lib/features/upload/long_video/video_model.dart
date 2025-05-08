import 'dart:convert';

class VideoModel {
  final String videoUrl;
  final String thumbnail;
  final String description;
  final String title;
  final DateTime datePublished;
  final int views;
  final String videoId;
  final String userId;
  final List likes;
  final String type;
  VideoModel({
    required this.videoUrl,
    required this.thumbnail,
    required this.description,
    required this.title,
    required this.datePublished,
    required this.views,
    required this.videoId,
    required this.userId,
    required this.likes,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'videoUrl': videoUrl});
    result.addAll({'thumbnail': thumbnail});
    result.addAll({'description': description});
    result.addAll({'title': title});
    result.addAll({'datePublished': datePublished.millisecondsSinceEpoch});
    result.addAll({'views': views});
    result.addAll({'videoId': videoId});
    result.addAll({'userId': userId});
    result.addAll({'likes': likes});
    result.addAll({'type': type});

    return result;
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      videoUrl: map['videoUrl'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      description: map['description'] ?? '',
      title: map['title'] ?? '',
      datePublished: DateTime.fromMillisecondsSinceEpoch(map['datePublished']),
      views: map['views']?.toInt() ?? 0,
      videoId: map['videoId'] ?? '',
      userId: map['userId'] ?? '',
      likes: List.from(map['likes']),
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source));
}
