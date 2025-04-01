import 'package:flutter/material.dart';

class MoodColors {
  static Color getGradientColorForMood(String? mood) {
    switch (mood?.toLowerCase()) {
      case 'angry':
      case 'horny':
        return Colors.red;
      case 'sad':
        return Colors.blue;
      case 'happy':
        return Colors.yellow;
      case 'relaxed':
        return Colors.green;
      case 'romantic':
        return Colors.pink;
      default:
        return Colors.blue;
    }
  }
}
