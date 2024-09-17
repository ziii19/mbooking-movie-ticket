import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/features/main/pages/cubit/nav_index_cubit.dart';
import 'package:mbooking/features/movie/presentation/pages/home/home_page.dart';
import 'package:mbooking/features/user/presentation/pages/profile/profile_page.dart';

import '../../../core/constants/assets_svg.dart';
import '../widgets/custom_bottom_nav.dart';

class MainPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const MainPage());
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomePage(),
      const Center(
          child: Text(
        'ticket',
        style: TextStyle(color: AppColors.white),
      )),
      const Center(
          child: Text(
        'movie',
        style: TextStyle(color: AppColors.white),
      )),
      const ProfilePage()
    ];
    return BlocBuilder<NavIndexCubit, int>(
      builder: (context, selectedIndex) {
        return Scaffold(
          body: pages[selectedIndex],
          bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex: selectedIndex,
            onItemTapped: (index) {
              context.read<NavIndexCubit>().setIndex(index);
            },
            items: [
              NavBarItem(
                icon: AssetsSvg.home,
                label: 'Home',
              ),
              NavBarItem(
                icon: AssetsSvg.ticket,
                label: 'Ticket',
              ),
              NavBarItem(
                icon: AssetsSvg.video,
                label: 'Movie',
              ),
              NavBarItem(
                icon: AssetsSvg.user,
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
