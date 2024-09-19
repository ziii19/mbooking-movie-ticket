import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';

class PickDateItem extends StatelessWidget {
  const PickDateItem({
    super.key,
    this.selectedIndex,
    required this.onItemTapped,
    required this.dates,
  });

  final int? selectedIndex;
  final ValueChanged<int> onItemTapped;
  final List<DateTime> dates;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: dates.map(
          (e) {
            int index = dates.indexOf(e);
            return Padding(
              padding: EdgeInsets.only(
                left: e == dates.first ? 16 : 0,
                right: 16,
              ),
              child: GestureDetector(
                onTap: () => onItemTapped(index),
                child: Container(
                  padding: const EdgeInsets.all(4).copyWith(top: 16),
                  width: 50,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(37),
                    color: selectedIndex == index
                        ? AppColors.yellow
                        : AppColors.enabled,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('MMM').format(dates[index]),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: selectedIndex == index
                              ? AppColors.black
                              : AppColors.outline,
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: selectedIndex == index
                              ? AppColors.enabled
                              : AppColors.gray,
                        ),
                        child: Center(
                          child: Text(
                            DateFormat('d').format(dates[index]),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.outline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
