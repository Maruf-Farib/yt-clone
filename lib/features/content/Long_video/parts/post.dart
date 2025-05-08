import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yt/features/upload/long_video/video_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class Post extends StatelessWidget {
  final VideoModel video;
  const Post({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(imageUrl: video.thumbnail),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 5.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 20,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 8),
                child: Text(
                  video.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.sizeOf(context).width * 0.135),
          child: Row(
            children: [
              Text(
                'Ahmad Amini',
                style: const TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  video.views == 0 ? "No View" : "${video.views} views",
                  style: const TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Text(
                timeago.format(video.datePublished),
                style: const TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
