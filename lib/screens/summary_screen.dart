import 'package:flutter/material.dart';
import '../models/diary_entry.dart';
import 'package:hive/hive.dart';
import '../utils/emotion_mapper.dart';
import 'diary_list_screen.dart';

class SummaryScreen extends StatelessWidget {
  final String originalText;
  final String summary;
  final String emotion;

  const SummaryScreen({
    super.key,
    required this.originalText,
    required this.summary,
    required this.emotion,
  });

  void _saveDiary(BuildContext context) async {
    final diaryBox = Hive.box<DiaryEntry>('diaryBox');
    final newEntry = DiaryEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      originalText: originalText,
      summary: summary,
      emotion: emotion,
      createdAt: DateTime.now(),
    );
    await diaryBox.put(newEntry.id, newEntry);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const DiaryListScreen()),
          (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final emoji = getEmoji(emotion);
    final color = getColor(emotion);

    return Scaffold(
      appBar: AppBar(title: const Text('요약 결과')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('원본 일기:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(originalText),
            const SizedBox(height: 16),
            const Text('요약:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(summary),
            const SizedBox(height: 16),
            const Text('감정:', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 30)),
                const SizedBox(width: 8),
                Text(emotion, style: TextStyle(fontSize: 24, color: color)),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _saveDiary(context),
              child: const Text('저장하고 목록으로'),
            ),
          ],
        ),
      ),
    );
  }
}
