import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt/cores/widgets/flat_button.dart';
import 'package:yt/features/auth/repository/user_data_service.dart';

final formKey = GlobalKey<FormState>();

class UsernamePage extends ConsumerStatefulWidget {
  final String displayName;
  final String profilePic;
  final String email;
  const UsernamePage({
    required this.displayName,
    required this.profilePic,
    required this.email,
    super.key,
  });

  @override
  ConsumerState<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends ConsumerState<UsernamePage> {
  final TextEditingController usernameController = TextEditingController();
  bool isValidate = true;
  void validateUsername() async {
    final usersMap = await FirebaseFirestore.instance.collection('users').get();
    final users = usersMap.docs.map((user) => user).toList();
    String? targettedUsername;
    for (var user in users) {
      if (usernameController.text == user.data()['username']) {
        targettedUsername = user.data()['username'];
        isValidate = false;
        setState(() {});
      }
      if (usernameController.text != targettedUsername) {
        isValidate = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 26,
              ),
              child: Text(
                'Enter your Username',
                style: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Form(
                child: TextFormField(
                  controller: usernameController,
                  key: formKey,
                  onChanged: (value) {
                    validateUsername();
                  },
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    return isValidate ? null : "Username Already Taken";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Username",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepPurple,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                    ),
                    suffixIcon: isValidate
                        ? Icon(
                            Icons.verified_user_rounded,
                          )
                        : Icon(
                            Icons.cancel,
                          ),
                    suffixIconColor: isValidate ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
              child: FlatButton(
                text: 'CONTINUE',
                onPressed: () async {
                  isValidate
                      ? await ref.read(userDataProvider).addUserDataToFirestore(
                            displayName: widget.displayName,
                            username: usernameController.text,
                            email: widget.email,
                            description: '',
                            profilePic: widget.profilePic,
                          )
                      : null;
                },
                colour: isValidate ? Colors.green : Colors.green.shade100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
