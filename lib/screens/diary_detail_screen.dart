import 'package:flutter/material.dart';
import '../models/diary_entry.dart';
import '../utils/emotion_mapper.dart';

class DiaryDetailScreen extends StatelessWidget {
  final DiaryEntry diary;

  const DiaryDetailScreen({super.key, required this.diary});

  @override
  Widget build(BuildContext context) {
    final emoji = EmotionMapper.getEmoji(diary.emotion);
    final color = EmotionMapper.getColor(diary.emotion);

    return Scaffold(
      appBar: AppBar(title: Text('일기 상세보기')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('작성일: ${diary.createdAt.toLocal()}'.split(' ')[0],
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 16),
            Text('원문:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(diary.originalText),
            SizedBox(height: 24),
            Text('요약:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(diary.summary),
            SizedBox(height: 24),
            Text('감정:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Text(emoji, style: TextStyle(fontSize: 30)),
                SizedBox(width: 8),
                Text(diary.emotion, style: TextStyle(fontSize: 24, color: color)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
