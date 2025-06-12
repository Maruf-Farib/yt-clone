class CommentModel {
  final String commentText;
  final String videoId;
  final String commentId;
  final String displayName;
  final String profilePic;
  CommentModel({
    required this.commentText,
    required this.videoId,
    required this.commentId,
    required this.displayName,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'commentText': commentText});
    result.addAll({'videoId': videoId});
    result.addAll({'commentId': commentId});
    result.addAll({'displayName': displayName});
    result.addAll({'profilePic': profilePic});

    return result;
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      commentText: map['commentText'] ?? '',
      videoId: map['videoId'] ?? '',
      commentId: map['commentId'] ?? '',
      displayName: map['displayName'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }
}
