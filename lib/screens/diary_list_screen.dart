// lib/screens/diary_list_screen.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/diary_entry.dart';
import 'summary_screen.dart';

class DiaryListScreen extends StatelessWidget {
  const DiaryListScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('일기 목록')),
      body: ValueListenableBuilder<Box<DiaryEntry>>(
        valueListenable: Hive.box<DiaryEntry>('diaryBox').listenable(),
        builder: (context, diaryBox, _) {
          final entries = diaryBox.values.toList().cast<DiaryEntry>();
          if (entries.isEmpty) {
            return const Center(child: Text('저장된 일기가 없습니다.'));
          }
          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final diary = entries[index];
              final emoji = getEmoji(diary.emotion);
              final color = getColor(diary.emotion);
              return ListTile(
                title: Text(diary.summary),
                subtitle: Text(
                  '${emoji} ${diary.emotion}  -  ${diary.createdAt.toLocal().toString().split(' ')[0]}',
                  style: TextStyle(color: color),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SummaryScreen(
                        originalText: diary.originalText,
                        summary: diary.summary,
                        emotion: diary.emotion,
                      ),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await diaryBox.delete(diary.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
