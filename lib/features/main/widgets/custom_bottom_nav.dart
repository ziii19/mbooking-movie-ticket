import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final List<NavBarItem> items;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.border,
            width: 2,
          ),
        ),
        color: AppColors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          int index = items.indexOf(item);
          return InkWell(
            borderRadius: BorderRadius.circular(99999),
            onTap: () => onItemTapped(index),
            child: SizedBox(
              height: 70,
              width: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    item.icon,
                    colorFilter: ColorFilter.mode(
                      selectedIndex == index
                          ? AppColors.yellow
                          : AppColors.white,
                      BlendMode.srcIn,
                    ),
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: selectedIndex == index
                          ? AppColors.yellow
                          : AppColors.white,
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class NavBarItem {
  final String icon;
  final String label;

  NavBarItem({
    required this.icon,
    required this.label,
  });
}
