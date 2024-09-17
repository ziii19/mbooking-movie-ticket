
  import 'dart:math';

int generateRandomInt(int num) {
    final random = Random();
    return random.nextInt(num) + 1; // Generates a number from 1 to 10
  }