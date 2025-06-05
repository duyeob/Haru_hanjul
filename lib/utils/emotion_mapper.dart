import 'package:flutter/material.dart';

String getEmoji(String emotion) {
  switch (emotion.toLowerCase()) {
    case 'positive':
      return '😊';
    case 'negative':
      return '😢';
    case 'neutral':
      return '😐';
    default:
      return '❓';
  }
}

Color getColor(String emotion) {
  switch (emotion.toLowerCase()) {
    case 'positive':
      return Colors.green;
    case 'negative':
      return Colors.red;
    case 'neutral':
      return Colors.grey;
    default:
      return Colors.black;
  }
}
