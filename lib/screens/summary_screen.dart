import 'package:flutter/material.dart';
import '../models/diary_entry.dart';
import 'package:hive/hive.dart';

class SummaryScreen extends StatelessWidget {
  final String originalText;
  final String summary;
  final String emotion;
  final double emotionScore;

  const SummaryScreen({
    super.key,
    required this.originalText,
    required this.summary,
    required this.emotion,
    required this.emotionScore,
  });

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

  void _saveDiary(BuildContext context) async {
    final diaryBox = await Hive.openBox<DiaryEntry>('diaryBox');
    final newEntry = DiaryEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      originalText: originalText,
      summary: summary,
      emotion: emotion,
      emotionScore: emotionScore,
      createdAt: DateTime.now(),
    );
    await diaryBox.put(newEntry.id, newEntry);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('일기가 저장되었습니다.')),
    );

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final emoji = getEmoji(emotion);
    final color = getColor(emotion);

    return Scaffold(
      appBar: AppBar(title: const Text('요약 및 감정 결과')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('원본 일기:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(originalText),
              const SizedBox(height: 24),
              const Text('요약:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(summary),
              const SizedBox(height: 24),
              const Text('감정:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 30)),
                  const SizedBox(width: 8),
                  Text(
                    '$emotion (${(emotionScore * 100).toStringAsFixed(1)}%)',
                    style: TextStyle(fontSize: 24, color: color),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _saveDiary(context),
                    child: const Text('저장하기'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('목록으로'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
