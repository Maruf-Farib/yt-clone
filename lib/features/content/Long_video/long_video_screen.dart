import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yt/cores/screens/error_page.dart';
import 'package:yt/cores/screens/loader.dart';
import 'package:yt/features/content/Long_video/parts/post.dart';
import 'package:yt/features/upload/long_video/video_model.dart';

class LongVideoScreen extends StatelessWidget {
  const LongVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('videos').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return const ErrorPage();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            final videoMaps = snapshot.data!.docs;
            final videos = videoMaps.map(
              (video) {
                return VideoModel.fromMap(video.data());
              },
            ).toList();
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return Post(
                  video: videos[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
