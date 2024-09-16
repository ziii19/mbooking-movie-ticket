import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mbooking/core/constants/assets_images.dart';
import 'package:mbooking/features/auth/presentation/pages/sign_up/sign_up_page.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../widgets/bottom_auth_text.dart';
import '../sign_in/sign_in_page.dart';

part 'section/slider_section.dart';

class AuthPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const AuthPage());
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(width: 150, child: Image.asset(AssetsImages.logo)),
              const SizedBox(height: 60),
              const MovieSlider(),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, SignInPage.route());
                },
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(context, SignUpPage.route());
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 30),
              const BottomAuthText()
            ],
          ),
        ),
      ),
    );
  }
}
