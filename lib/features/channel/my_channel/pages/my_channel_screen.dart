import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt/cores/screens/error_page.dart';
import 'package:yt/cores/screens/loader.dart';
import 'package:yt/features/auth/provider/current_user_provider.dart';
import 'package:yt/features/channel/my_channel/parts/buttons.dart';
import 'package:yt/features/channel/my_channel/parts/tab_bar.dart';
import 'package:yt/features/channel/my_channel/parts/tab_bar_view.dart';
import 'package:yt/features/channel/my_channel/parts/top_header.dart';

class MyChannelScreen extends ConsumerWidget {
  const MyChannelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserProvider).when(
          data: (currentUser) {
            return DefaultTabController(
              length: 7,
              child: Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        TopHeader(user: currentUser),
                        Text('More about this channel'),
                        Buttons(),
                        PageTabBar(),
                        TabPages(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          error: (error, stackTrace) => const ErrorPage(),
          loading: () => const Loader(),
        );
  }
}
