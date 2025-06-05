import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt/features/auth/models/user_data_model.dart';

final userDataProvider = Provider(
  (ref) => UserDataService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class UserDataService {
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  UserDataService({
    required this.auth,
    required this.firestore,
  });

  addUserDataToFirestore({
    required String displayName,
    required String username,
    required String email,
    required String description,
    required String profilePic,
  }) async {
    UserDataModel user = UserDataModel(
      displayName: displayName,
      username: username,
      email: email,
      userId: auth.currentUser!.uid,
      description: description,
      profilePic: profilePic,
      videos: 0,
      subscriptions: [],
      type: 'user',
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user.toMap());
  }

  Future<UserDataModel> fetchCurrentUserData() async {
    final currentUserMap =
        await firestore.collection('users').doc(auth.currentUser!.uid).get();
    UserDataModel user = UserDataModel.fromMap(currentUserMap.data()!);
    return user;
  }

  Future<UserDataModel> fetchAnyUserData(userId) async {
    final currentUserMap =
        await firestore.collection('users').doc(userId).get();
    UserDataModel user = UserDataModel.fromMap(currentUserMap.data()!);
    return user;
  }
}
