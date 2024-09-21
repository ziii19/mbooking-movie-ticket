import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbooking/core/constants/movie_category.dart';
import 'package:mbooking/features/main/pages/cubit/nav_index_cubit.dart';
import 'package:mbooking/features/movie/presentation/blocs/cubit/category_index_cubit.dart';
import 'package:mbooking/features/movie/presentation/pages/home/home_page.dart';
import 'package:mbooking/features/movie/presentation/pages/movie/movie_page.dart';
import 'package:mbooking/features/transaction/presentation/pages/my_ticket/my_ticket.dart';
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
      const MyTicket(),
      const MoviePage(),
      const ProfilePage()
    ];
    return BlocBuilder<NavIndexCubit, int>(
      builder: (context, selectedIndex) {
        return Scaffold(
          body: pages[selectedIndex],
          bottomNavigationBar: CustomBottomNavigationBar(
            selectedIndex: selectedIndex,
            onItemTapped: (index) {
              if (index == 2) {
                context
                    .read<CategoryIndexCubit>()
                    .setCategory(MovieCategory.nowPlaying);
              }
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
