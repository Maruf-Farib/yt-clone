import 'package:flutter/material.dart';
import 'package:yt/features/account/account_page.dart';
import 'package:yt/features/channel/my_channel/pages/channel_settings.dart';
import 'package:yt/features/channel/my_channel/pages/my_channel_screen.dart';
import 'package:yt/features/content/Long_video/long_video_screen.dart';

List pages = [
  LongVideoScreen(),
  MyChannelScreen(),
  Center(
    child: Text('Upload'),
  ),
  Center(
    child: Text('Search'),
  ),
  MyChannelSettings(),
  Center(
    child: Text('Logout'),
  ),
];
