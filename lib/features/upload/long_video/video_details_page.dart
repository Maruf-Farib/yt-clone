import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:yt/cores/methods.dart';
import 'package:yt/features/upload/long_video/video_repository.dart';

class VideoDetailsPage extends ConsumerStatefulWidget {
  final File? video;
  const VideoDetailsPage({required this.video, super.key});

  @override
  ConsumerState<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends ConsumerState<VideoDetailsPage> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  File? image;
  bool thumbnailUploaded = false;
  String randomNumber = Uuid().v4();
  String videoId = Uuid().v4();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Video Title',
                style: TextStyle(color: Colors.blueGrey),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Enter the video title',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Video Description',
                style: TextStyle(color: Colors.blueGrey),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: descController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Enter the video Description',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      image = await pickImage();
                      if (image != null) {
                        thumbnailUploaded = true;
                        // await putFileInStorage(
                        //   image,
                        //   randomNumber,
                        //   'image',
                        // );
                        setState(() {});
                      }
                    },
                    child: Text(
                      'UPLOAD THUMBNAIL',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              thumbnailUploaded
                  ? Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Image.file(image!),
                    )
                  : SizedBox(),
              Spacer(),
              thumbnailUploaded
                  ? Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            final thumbnail = await putFileInCloudinary(
                              file: image,
                              type: 'image',
                            );
                            final videoUrl = await putFileInCloudinary(
                              file: widget.video,
                              type: 'video',
                            );
                            await ref
                                .watch(videoProvider)
                                .uploadVideoToFirestore(
                                  description: descController.text,
                                  title: titleController.text,
                                  videoUrl: videoUrl,
                                  thumbnail: thumbnail,
                                  datePublished: DateTime.now(),
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  videoId: videoId,
                                );
                            Navigator.pop(context);
                          },
                          child: Text(
                            'PUBLISH VIDEO',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
