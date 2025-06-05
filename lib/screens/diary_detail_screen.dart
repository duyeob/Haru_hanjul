import 'package:flutter/material.dart';
import '../models/diary_entry.dart';
import '../utils/emotion_mapper.dart';

class DiaryDetailScreen extends StatelessWidget {
  final DiaryEntry entry;

  const DiaryDetailScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final emoji = getEmoji(entry.emotion);
    final color = getColor(entry.emotion);

    return Scaffold(
      appBar: AppBar(title: const Text('일기 상세 보기')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text('날짜', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(entry.createdAt.toLocal().toString()),
            const SizedBox(height: 12),
            const Text('원문', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(entry.originalText),
            const SizedBox(height: 12),
            const Text('요약', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(entry.summary),
            const SizedBox(height: 12),
            const Text('감정', style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 30)),
                const SizedBox(width: 8),
                Text(entry.emotion, style: TextStyle(fontSize: 24, color: color)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
