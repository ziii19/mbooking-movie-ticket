import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/core/constants/assets_images.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/features/auth/presentation/widgets/bottom_auth_text.dart';

import '../../../../../core/widgets/back_nav.dart';
import '../../../../../core/widgets/input_text.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/user/user_bloc.dart';
import '../../widgets/or_continue.dart';

part 'section/form_sign_in.dart';

class SignInPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignInPage());
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
            // TODO: Navigate to home
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.user.name),
              ),
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
                    text: 'Sign In',
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
                  const _FormSignIn(),
                  const SizedBox(height: 250),
                  const OrContinue(),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.enabled,
                      foregroundColor: AppColors.white,
                    ),
                    onPressed: () {},
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
