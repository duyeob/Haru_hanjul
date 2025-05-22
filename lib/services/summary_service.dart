import 'dart:convert';
import 'package:http/http.dart' as http;

class SummaryService {
  static const String _apiUrl = 'https://api-inference.huggingface.co/models/google/pegasus-xsum';
  static const String _apiToken = 'token';

  static Future<String> summarizeText(String text) async {
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
      if (data is List && data.isNotEmpty) {
        final summary = data[0]['summary_text'];
        if (summary != null) {
          return summary;
        }
      }
      return '요약 결과 없음';
    } else {
      print('요약 오류: ${response.statusCode}');
      print('응답: ${response.body}');
      return '요약 실패';
    }
  }
}
