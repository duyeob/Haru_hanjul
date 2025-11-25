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
    // 긍정: 화사한 녹색 계열 (교수님 피드백 반영)
      return const Color(0xFF4CAF50);
    case 'negative':
    // 부정: 완전 새빨간 색 (교수님 피드백 반영)
      return const Color(0xFFE53935);
    case 'neutral':
      return Colors.grey;
    default:
      return Colors.black;
  }
}