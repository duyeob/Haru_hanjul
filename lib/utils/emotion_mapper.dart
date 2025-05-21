import 'package:flutter/material.dart';

class EmotionMapper {
  static const Map<String, String> emotionEmoji = {
    '기쁨': '😊',
    '슬픔': '😢',
    '분노': '😠',
    '불안': '😰',
    '사랑': '❤️',
    '지침': '😩',
    '놀람': '😲',
    '평온': '😌',
    '외로움': '🥺',
    '혼란': '😵',
  };

  static const Map<String, Color> emotionColor = {
    '기쁨': Colors.amber,
    '슬픔': Colors.blue,
    '분노': Colors.redAccent,
    '불안': Colors.teal,
    '사랑': Colors.pinkAccent,
    '지침': Colors.grey,
    '놀람': Colors.deepOrange,
    '평온': Colors.green,
    '외로움': Colors.indigo,
    '혼란': Colors.brown,
  };

  static String getEmoji(String emotion) {
    return emotionEmoji[emotion.trim()] ?? '❓';
  }

  static Color getColor(String emotion) {
    return emotionColor[emotion.trim()] ?? Colors.black;
  }
}
