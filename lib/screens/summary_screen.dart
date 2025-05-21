import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/diary_entry.dart';
import '../utils/emotion_mapper.dart';

class SummaryScreen extends StatefulWidget {
  final String diaryId;
  final String originalText;
  final String summary;
  final String emotion;

  SummaryScreen({
    required this.diaryId,
    required this.originalText,
    required this.summary,
    required this.emotion,
  });

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  bool _isSaving = false;
  bool _saved = false;

  void _saveDiary() async {
    setState(() => _isSaving = true);

    final diaryBox = Hive.box<DiaryEntry>('diaryBox');
    final entry = DiaryEntry(
      id: widget.diaryId,
      originalText: widget.originalText,
      summary: widget.summary,
      emotion: widget.emotion,
      createdAt: DateTime.now(),
    );

    await diaryBox.put(entry.id, entry);

    setState(() {
      _isSaving = false;
      _saved = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final emoji = EmotionMapper.getEmoji(widget.emotion);
    final color = EmotionMapper.getColor(widget.emotion);

    return Scaffold(
      appBar: AppBar(title: Text('요약 결과')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('요약:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(widget.summary),
            SizedBox(height: 24),
            Text('감정:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              children: [
                Text(emoji, style: TextStyle(fontSize: 30)),
                SizedBox(width: 8),
                Text(
                  widget.emotion,
                  style: TextStyle(fontSize: 24, color: color),
                ),
              ],
            ),
            SizedBox(height: 40),
            _saved
                ? Text('저장되었습니다!', style: TextStyle(color: Colors.green))
                : ElevatedButton(
              onPressed: _isSaving ? null : _saveDiary,
              child: _isSaving
                  ? CircularProgressIndicator()
                  : Text('일기 저장하기'),
            ),
          ],
        ),
      ),
    );
  }
}
