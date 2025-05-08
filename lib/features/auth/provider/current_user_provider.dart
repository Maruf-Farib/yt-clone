import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt/features/auth/models/user_data_model.dart';
import 'package:yt/features/auth/repository/user_data_service.dart';

final currentUserProvider = FutureProvider(
  (ref) async {
    final UserDataModel user =
        await ref.watch(userDataProvider).fetchCurrentUserData();
    return user;
  },
);
