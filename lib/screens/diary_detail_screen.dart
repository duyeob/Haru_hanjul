import 'package:flutter/material.dart';
import '../models/diary_entry.dart';
import '../utils/emotion_mapper.dart';

class DiaryDetailScreen extends StatelessWidget {
  final DiaryEntry entry;

  const DiaryDetailScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final dateStr = entry.createdAt.toLocal().toString().split(' ')[0];
    final emoji = getEmoji(entry.emotion);
    final emotionColor = getColor(entry.emotion);

    return Scaffold(
      appBar: AppBar(
        title: const Text('일기 상세 보기'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              '🗓 작성일',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              dateStr,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            Text(
              '📝 원본 내용',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              entry.originalText,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            Text(
              '📌 요약',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              entry.summary,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            Text(
              '😊 감정 분석',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(width: 8),
                Text(
                  entry.emotion,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: emotionColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
