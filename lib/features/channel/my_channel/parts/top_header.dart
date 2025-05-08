import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yt/features/auth/models/user_data_model.dart';

class TopHeader extends StatelessWidget {
  final UserDataModel user;
  const TopHeader({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 38,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(user.profilePic),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 4.0),
          child: Text(
            user.displayName,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 9.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.blueGrey,
              ),
              children: [
                TextSpan(text: '@${user.username}  '),
                TextSpan(text: '${user.videos} videos  '),
                TextSpan(text: '${user.subscriptions.length} subscriptions')
              ],
            ),
          ),
        ),
      ],
    );
  }
}
