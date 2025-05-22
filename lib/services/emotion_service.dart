import 'dart:convert';
import 'package:http/http.dart' as http;

class EmotionService {
  static const String _apiUrl = 'https://api-inference.huggingface.co/models/daniel604/koelectra-base-v3-finetuned-emotion';
  static const String _apiToken = 'token';

  static Future<String> analyzeEmotion(String text) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Authorization': 'Bearer $_apiToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'inputs': text}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // 감정 레이블 중 확률 가장 높은 것 선택
      if (data is List && data.isNotEmpty) {
        final results = data[0];
        if (results is Map && results.containsKey('label')) {
          return results['label'];
        } else if (results is List) {
          // 모델마다 다르니 디버깅 필요
          return results[0]['label'] ?? '감정 알 수 없음';
        }
      }
      return '감정 알 수 없음';
    } else {
      print('감정 분석 오류: ${response.statusCode}');
      print('응답: ${response.body}');
      return '감정 분석 실패';
    }
  }
}
