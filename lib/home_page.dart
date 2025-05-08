// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt/cores/screens/error_page.dart';
import 'package:yt/cores/screens/loader.dart';
import 'package:yt/cores/widgets/image_button.dart';
import 'package:yt/features/account/account_page.dart';
import 'package:yt/features/auth/provider/current_user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:yt/features/content/bottom_navigation.dart';
import 'package:yt/features/upload/upload_bottom_sheet.dart';
import 'package:yt/pages_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/youtube.jpg",
                  height: 36,
                ),
                const SizedBox(width: 4),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SizedBox(
                    height: 42,
                    child: ImageButton(
                      image: "cast.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: SizedBox(
                    height: 38,
                    child: ImageButton(
                      image: "notification.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: SizedBox(
                    height: 41.5,
                    child: ImageButton(
                      image: "search.png",
                      onPressed: () {},
                      haveColor: false,
                    ),
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return ref.watch(currentUserProvider).when(
                          data: (data) {
                            return Padding(
                              padding: EdgeInsets.only(right: 12.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return AccountPage(user: data);
                                      },
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 14,
                                  backgroundImage: CachedNetworkImageProvider(
                                    data.profilePic,
                                  ),
                                ),
                              ),
                            );
                          },
                          error: (error, stackTrace) => ErrorPage(),
                          loading: () => Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Loader(),
                          ),
                        );
                  },
                ),
              ],
            ),
            Expanded(
              child: pages[currentIndex],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        onPressed: (index) {
          if (index != 2) {
            currentIndex = index;
            setState(() {});
          } else {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return CreateBottomSheet();
              },
            );
          }
        },
      ),
    );
  }
}
