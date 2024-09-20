import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class PickTimeItem extends StatelessWidget {
  final int? selectedIndex;
  final Function(int) onItemTapped;
  final List<String> times;
  const PickTimeItem({
    super.key,
    this.selectedIndex,
    required this.onItemTapped,
    required this.times,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: times.map((time) {
          int index = times.indexOf(time);
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16 : 0,
              right: 16,
            ),
            child: GestureDetector(
              onTap: () => onItemTapped(index),
              child: Container(
                width: 90,
                height: 36,
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? AppColors.yellow9
                      : AppColors.enabled,
                  borderRadius: BorderRadius.circular(16),
                  border: selectedIndex == index
                      ? Border.all(color: AppColors.yellow)
                      : null,
                ),
                child: Center(
                  child: Text(
                    time,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
