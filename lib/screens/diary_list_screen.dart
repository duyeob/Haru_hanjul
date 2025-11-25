import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/diary_entry.dart';
import 'diary_detail_screen.dart';
import 'input_screen.dart';
import '../widgets/emotion_chart.dart';
import '../utils/emotion_mapper.dart'; // 이모지 및 색상 사용을 위해 추가

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
        title: const Text(
          '일기 삭제',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: const Text('이 소중한 기록을 정말로 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('취소', style: TextStyle(color: Colors.grey.shade600)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('삭제', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await diaryBox.delete(id);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final entries = diaryBox.values.toList().reversed.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Text(
          '나의 기록장',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit_note, color: Colors.teal.shade500),
            tooltip: '새 일기 쓰기',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InputScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: entries.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book_outlined,
              size: 60,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 10),
            Text(
              '아직 저장된 일기가 없어요.',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
            ),
            Text(
              '첫 일기를 작성해 보세요.',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
            ),
          ],
        ),
      )
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Card(
              elevation: 6, // 드롭 쉐도우
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '나의 감정 패턴 📈',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const SizedBox(height: 200, child: EmotionChart()),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                final emoji = getEmoji(entry.emotion);
                final emojiColor = getColor(entry.emotion);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 6),
                  child: Card(
                    elevation: 4, // 드롭 쉐도우
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(color: Colors.grey.shade200, width: 1),
                    ),
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 18),
                      leading: Text(
                        emoji,
                        style: TextStyle(fontSize: 24, color: emojiColor),
                      ),
                      title: Text(
                        entry.summary,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.4),
                      ),
                      subtitle: Text(
                        entry.createdAt
                            .toLocal()
                            .toString()
                            .split(' ')[0]
                            .replaceAll('-', '. '),
                        style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DiaryDetailScreen(entry: entry),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.red.shade400),
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