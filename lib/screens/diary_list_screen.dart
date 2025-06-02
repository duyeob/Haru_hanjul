import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/diary_entry.dart';

class DiaryListScreen extends StatefulWidget {
  const DiaryListScreen({super.key});

  @override
  State<DiaryListScreen> createState() => _DiaryListScreenState();
}

class _DiaryListScreenState extends State<DiaryListScreen> {
  late Box<DiaryEntry> diaryBox;

  @override
  void initState() {
    super.initState();
    diaryBox = Hive.box<DiaryEntry>('diaryBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('일기 목록')),
      body: ValueListenableBuilder(
        valueListenable: diaryBox.listenable(),
        builder: (context, Box<DiaryEntry> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('작성된 일기가 없습니다.'));
          }

          final entries = box.values.toList().reversed.toList();

          return ListView.builder(
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];

              return ListTile(
                title: Text(
                  entry.summary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${entry.createdAt.toLocal()} - 감정: ${entry.emotion} (${(entry.emotionScore * 100).toStringAsFixed(1)}%)',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
