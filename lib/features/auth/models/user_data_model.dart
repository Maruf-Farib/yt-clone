import 'dart:convert';

class UserDataModel {
  final String displayName;
  final String username;
  final String email;
  final String userId;
  final String description;
  final String profilePic;
  final int videos;
  final List subscriptions;
  final String type;

  UserDataModel({
    required this.displayName,
    required this.username,
    required this.email,
    required this.userId,
    required this.description,
    required this.profilePic,
    required this.videos,
    required this.subscriptions,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'displayName': displayName});
    result.addAll({'username': username});
    result.addAll({'email': email});
    result.addAll({'userId': userId});
    result.addAll({'description': description});
    result.addAll({'profilePic': profilePic});
    result.addAll({'videos': videos});
    result.addAll({'subscriptions': subscriptions});
    result.addAll({'type': type});

    return result;
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      displayName: map['displayName'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      userId: map['userId'] ?? '',
      description: map['description'] ?? '',
      profilePic: map['profilePic'] ?? '',
      videos: map['videos']?.toInt() ?? 0,
      subscriptions: List.from(map['subscriptions'] ?? []),
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) =>
      UserDataModel.fromMap(json.decode(source));
}
