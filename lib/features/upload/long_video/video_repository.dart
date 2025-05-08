import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt/features/upload/long_video/video_model.dart';

final videoProvider = Provider((ref) {
  return VideoRepository(
      firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance);
});

class VideoRepository {
  FirebaseFirestore firestore;
  FirebaseAuth auth;
  VideoRepository({
    required this.firestore,
    required this.auth,
  });

  uploadVideoToFirestore({
    required String title,
    required String description,
    required String videoUrl,
    required String thumbnail,
    required DateTime datePublished,
    required String userId,
    required String videoId,
  }) async {
    VideoModel video = VideoModel(
      videoUrl: videoUrl,
      description: description,
      thumbnail: thumbnail,
      title: title,
      datePublished: datePublished,
      views: 0,
      videoId: videoId,
      userId: userId,
      likes: [],
      type: 'video',
    );
    await firestore.collection('videos').doc(videoId).set(video.toMap());
  }
}
