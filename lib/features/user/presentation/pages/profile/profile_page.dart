import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mbooking/core/constants/assets_svg.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/core/utils/capital.dart';
import 'package:mbooking/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:mbooking/features/auth/presentation/pages/auth/auth_page.dart';
import 'package:mbooking/features/main/pages/cubit/nav_index_cubit.dart';
import 'package:mbooking/features/main/pages/main_page.dart';

import '../../../../auth/presentation/blocs/user/user_bloc.dart';
import '../../widgets/build_profile_menu.dart';
import '../../widgets/build_user_info.dart';

part 'section/user_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        } else if (state is AuthInitial) {
          Navigator.pushAndRemoveUntil(
            context,
            AuthPage.route(),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                const _UserProfile(),
                const SizedBox(height: 60.0),
                BuildProfileMenu(
                  icon: AssetsSvg.ticket2,
                  text: 'My ticket',
                  onTap: () {
                    context.read<NavIndexCubit>().setIndex(1);
                    Navigator.push(context, MainPage.route());
                  },
                ),
                BuildProfileMenu(
                  icon: AssetsSvg.shoppingCart,
                  text: 'Payment history',
                  onTap: () {},
                ),
                BuildProfileMenu(
                  icon: AssetsSvg.lock,
                  text: 'Change password',
                  onTap: () {},
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogout());
                  },
                  child: const Text('Sign Out'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
