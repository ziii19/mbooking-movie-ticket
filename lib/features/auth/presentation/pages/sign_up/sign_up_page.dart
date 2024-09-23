import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/core/constants/assets_images.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/features/auth/presentation/widgets/bottom_auth_text.dart';

import '../../../../../core/utils/pick_image.dart';
import '../../../../../core/widgets/back_nav.dart';
import '../../../../../core/widgets/input_text.dart';
import '../../../../main/pages/main_page.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/or_continue.dart';

part 'section/form_sign_up.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is UserSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MainPage.route(),
              (route) => false,
            );
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackNav(
                    text: 'Sign Up',
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      await Future.delayed(const Duration(milliseconds: 100));
                      if (context.mounted) {
                        if (Navigator.canPop(context)) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  ),
                  const _FormSignUp(),
                  const SizedBox(height: 100),
                  const OrContinue(),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.enabled,
                      foregroundColor: AppColors.white,
                    ),
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthGoogleSignIn());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AssetsImages.google),
                        const SizedBox(width: 12),
                        const Text('Google')
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const BottomAuthText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
