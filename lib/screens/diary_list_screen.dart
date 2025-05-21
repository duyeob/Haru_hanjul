import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/diary_entry.dart';
import 'diary_detail_screen.dart';

class DiaryListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final diaryBox = Hive.box<DiaryEntry>('diaryBox');

    return Scaffold(
      appBar: AppBar(title: Text('일기 보관함')),
      body: ValueListenableBuilder(
        valueListenable: diaryBox.listenable(),
        builder: (context, Box<DiaryEntry> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text('저장된 일기가 없습니다.'));
          }

          final entries = box.values.toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final diary = entries[index];
              return ListTile(
                title: Text(diary.summary.length > 30
                    ? diary.summary.substring(0, 30) + '...'
                    : diary.summary),
                subtitle: Text(
                  '${diary.createdAt.toLocal()}'.split(' ')[0],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DiaryDetailScreen(diary: diary),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
