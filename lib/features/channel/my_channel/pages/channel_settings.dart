import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt/cores/screens/error_page.dart';
import 'package:yt/cores/screens/loader.dart';
import 'package:yt/features/auth/provider/current_user_provider.dart';
import 'package:yt/features/channel/my_channel/repository/edit_field.dart';
import 'package:yt/features/channel/my_channel/widgets/edit_setting_dialog.dart';
import 'package:yt/features/channel/my_channel/widgets/setting_field_item.dart';

class MyChannelSettings extends ConsumerStatefulWidget {
  const MyChannelSettings({super.key});

  @override
  ConsumerState<MyChannelSettings> createState() => _MyChannelSettingsState();
}

class _MyChannelSettingsState extends ConsumerState<MyChannelSettings> {
  bool isSwitch = false;
  @override
  Widget build(BuildContext context) {
    return ref.watch(currentUserProvider).when(
          data: (currentUser) {
            return Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/flutter background.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 180,
                          top: 68,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 30,
                            backgroundImage: CachedNetworkImageProvider(
                                currentUser.profilePic),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 15,
                          child: Image.asset(
                            'assets/icons/camera.png',
                            color: Colors.white,
                            height: 35,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SettingsItem(
                      identifier: 'Name',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SettingsDialog(
                              identifier: 'Display Name',
                              onSave: (channelName) {
                                ref
                                    .watch(editSettingsProvider)
                                    .editDisplayName(channelName);
                              },
                            );
                          },
                        );
                      },
                      value: currentUser.displayName,
                    ),
                    SettingsItem(
                      identifier: 'Handle',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SettingsDialog(
                              identifier: 'Username',
                              onSave: (channelName) {
                                ref
                                    .watch(editSettingsProvider)
                                    .editUsername(channelName);
                              },
                            );
                          },
                        );
                      },
                      value: '@${currentUser.username}',
                    ),
                    SettingsItem(
                      identifier: 'Description',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SettingsDialog(
                              identifier: 'Description',
                              onSave: (desc) {
                                ref
                                    .watch(editSettingsProvider)
                                    .editDescription(desc);
                              },
                            );
                          },
                        );
                      },
                      value: currentUser.description == ''
                          ? 'No Description'
                          : currentUser.description,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Keep all my subscribers private'),
                          Switch(
                            value: isSwitch,
                            onChanged: (value) {
                              isSwitch = value;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 6.0,
                      ),
                      child: Text(
                        'Changes made on your names and profile pictures are visible only to youtube and not other Google Services',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) => ErrorPage(),
          loading: () => Loader(),
        );
  }
}
