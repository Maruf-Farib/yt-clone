import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt/features/auth/repository/auth_service.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/youtube-signin.jpg',
                height: 150,
              ),
              Text(
                'Welcome to Youtube',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: InkWell(
                  onTap: () {
                    ref.read(authServiceProvider).signInWithGoogle();
                  },
                  child: Image.asset(
                    'assets/images/signinwithgoogle.png',
                    height: 60,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
