// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yt/features/upload/long_video/video_details_page.dart';
import 'package:http/http.dart' as http;

void showErrorSnackBar(String message, context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );

Future pickVideo(context) async {
  XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
  if (file != null) {
    File video = File(file.path);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return VideoDetailsPage(video: video);
      },
    ));
  }
}

Future pickImage() async {
  XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (file != null) {
    File image = File(file.path);
    return image;
  }
}

Future<String> putFileInStorage(file, number, fileType) async {
  final ref = FirebaseStorage.instance.ref().child("$fileType/$number");
  final upload = ref.putFile(file);
  final snapshot = await upload;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}

Future putFileInCloudinary({required file, required String type}) async {
  final url = Uri.parse('https://api.cloudinary.com/v1_1/dvc8dp1qy/upload');
  final request = http.MultipartRequest('POST', url)
    ..fields['upload_preset'] = 'sikkmfsk'
    ..fields['asset_folder'] = 'public/$type/'
    ..files.add(await http.MultipartFile.fromPath('file', file!.path));
  final response = await request.send();
  if (response.statusCode == 200) {
    final responseData = await response.stream.toBytes();
    final responseString = String.fromCharCodes(responseData);
    final jsonMap = jsonDecode(responseString);
    final url = jsonMap['url'];
    return url;
  } else {
    return null;
  }
}
