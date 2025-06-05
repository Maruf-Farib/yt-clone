import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt/features/auth/models/user_data_model.dart';
import 'package:yt/features/auth/repository/user_data_service.dart';

final currentUserProvider = FutureProvider<UserDataModel>(
  (ref) async {
    final UserDataModel user =
        await ref.watch(userDataProvider).fetchCurrentUserData();
    return user;
  },
);

final anyUserDataProvider = FutureProvider.family((ref, userId) async {
  final UserDataModel user =
      await ref.watch(userDataProvider).fetchAnyUserData(userId);
  return user;
});
