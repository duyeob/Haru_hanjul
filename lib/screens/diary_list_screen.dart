import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/diary_entry.dart';
import 'diary_detail_screen.dart';
import '../widgets/emotion_chart.dart';

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

  void _confirmDelete(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('삭제 확인'),
        content: const Text('이 일기를 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await diaryBox.delete(id);
      setState(() {}); // 상태 갱신
    }
  }

  @override
  Widget build(BuildContext context) {
    final entries = diaryBox.values.toList().reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('일기 목록'),
        backgroundColor: Colors.teal,
      ),
      body: entries.isEmpty
          ? const Center(
        child: Text(
          '저장된 일기가 없습니다.',
          style: TextStyle(fontSize: 16),
        ),
      )
          : Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            '감정 통계',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const SizedBox(height: 200, child: EmotionChart()),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      title: Text(
                        entry.summary,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        entry.createdAt
                            .toLocal()
                            .toString()
                            .split(' ')[0],
                        style: const TextStyle(color: Colors.grey),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DiaryDetailScreen(entry: entry),
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDelete(entry.id),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
