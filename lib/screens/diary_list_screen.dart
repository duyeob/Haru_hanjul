import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/diary_entry.dart';
import 'diary_detail_screen.dart';
import '../widgets/emotion_chart.dart';

class DiaryListScreen extends StatelessWidget {
  const DiaryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final diaryBox = Hive.box<DiaryEntry>('diaryBox');
    final entries = diaryBox.values.toList().reversed.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('일기 목록')),
      body: entries.isEmpty
          ? const Center(child: Text('저장된 일기가 없습니다.'))
          : ListView.builder(
        itemCount: entries.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) return const SizedBox(height: 200, child: EmotionChart());
          final entry = entries[index - 1];
          return ListTile(
            title: Text(entry.summary),
            subtitle: Text(entry.createdAt.toLocal().toString().split(' ')[0]),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DiaryDetailScreen(entry: entry),
              ),
            ),
          );
        },
      ),
    );
  }
}
