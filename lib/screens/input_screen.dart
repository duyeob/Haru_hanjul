import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'summary_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  void _processDiary() async {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('일기 내용을 입력해주세요')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await ApiService.processDiary(text);
      final summary = result['summary'] ?? '';
      final emotion = result['emotion'] ?? 'neutral';
      final emotionScore = result['emotion_score'] ?? 0.0;

      setState(() => _isLoading = false);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SummaryScreen(
            originalText: text,
            summary: summary,
            emotion: emotion,
            emotionScore: emotionScore,
          ),
        ),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('에러 발생: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('일기 입력')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 8,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '오늘의 감정을 기록해보세요',
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _processDiary,
              child: const Text('요약 및 감정 분석'),
            ),
          ],
        ),
      ),
    );
  }
}
