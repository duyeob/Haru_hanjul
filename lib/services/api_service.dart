import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _url = 'http://localhost:5000/summarize';

  static Future<Map<String, String>> analyzeText(String text) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'summary': data['summary'] ?? '',
        'emotion': data['emotion'] ?? 'Unknown',
      };
    } else {
      throw Exception('서버 통신 실패');
    }
  }
}


// emotion_mapper.dart
String mapEmotionToEmoji(String emotion) {
  switch (emotion.toLowerCase()) {
    case 'happy':
      return '😊';
    case 'sad':
      return '😢';
    case 'angry':
      return '😡';
    case 'neutral':
      return '😐';
    default:
      return '❓';
  }
}