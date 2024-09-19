import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum SeatStatus { available, reserved, selected }

class Seat {
  static Color seatColor(SeatStatus status) {
    switch (status) {
      case SeatStatus.available:
        return AppColors.enabled;
      case SeatStatus.reserved:
        return AppColors.yellow9;
      case SeatStatus.selected:
        return AppColors.yellow;
    }
  }

  static Color textColor(SeatStatus status) {
    switch (status) {
      case SeatStatus.available:
        return AppColors.gray1;
      case SeatStatus.reserved:
        return AppColors.yellow;
      case SeatStatus.selected:
        return AppColors.black;
    }
  }
}
