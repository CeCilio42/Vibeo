import 'package:flutter/material.dart';

class MoodColors {
  static Color getGradientColorForMood(String? mood) {
    switch (mood?.toLowerCase()) {
      case 'angry':
        return Colors.red[400] ?? Colors.red;
      case 'horny':
        return Colors.deepPurple[400] ?? Colors.purple;
      case 'sad':
        return Colors.indigo[400] ?? Colors.blue;
      case 'happy':
        return Colors.amber[400] ?? Colors.orange;
      case 'relaxed':
        return Colors.teal[400] ?? Colors.green;
      case 'romantic':
        return Colors.pink[400] ?? Colors.pink;
      default:
        return Colors.blueGrey;
    }
  }
}
