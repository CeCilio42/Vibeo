import 'package:flutter/material.dart';

class MoodColors {
  static Color getGradientColorForMood(String? mood) {
    switch (mood?.toLowerCase()) {
      case 'angry':
        return Colors.red[700] ?? Colors.red;
      case 'horny':
        return Colors.deepPurple;
      case 'sad':
        return Colors.indigo[600] ?? Colors.blue;
      case 'happy':
        return Colors.amber;
      case 'relaxed':
        return Colors.teal[400] ?? Colors.green;
      case 'romantic':
        return Colors.pink[300] ?? Colors.pink;
      default:
        return Colors.blueGrey;
    }
  }
}
