import 'package:flutter/material.dart';
import 'package:mbooking/core/theme/app_colors.dart';
import 'package:mbooking/features/movie/presentation/pages/home/home_page.dart';
import 'package:mbooking/features/user/presentation/pages/profile/profile_page.dart';

import '../../../core/constants/assets_svg.dart';
import '../widgets/custom_bottom_nav.dart';

class MainPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const MainPage());
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: (index) {
          _selectedIndex = index;
          setState(() {});
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
  }
}
