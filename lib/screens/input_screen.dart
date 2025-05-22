import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../services/summary_service.dart' as summary;
import '../services/emotion_service.dart' as emotion;

import 'summary_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _controller = TextEditingController();
  final _uuid = const Uuid();

  bool _isLoading = false;

  void _goToSummary() async {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('일기 내용을 입력해주세요')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final diaryId = _uuid.v4();

    // 요약 & 감정 분석 API 호출
    final summaryText = await summary.SummaryService.summarizeText(text);
    final emotionText = await emotion.EmotionService.analyzeEmotion(text);

    setState(() {
      _isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SummaryScreen(
          diaryId: diaryId,
          originalText: text,
          summary: summaryText,
          emotion: emotionText,
        ),
      ),
    );
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
              onPressed: _goToSummary,
              child: const Text('요약 및 감정 분석'),
            ),
          ],
        ),
      ),
    );
  }
}
