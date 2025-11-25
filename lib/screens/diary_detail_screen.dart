import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/diary_entry.dart';
import '../utils/emotion_mapper.dart'; // 감정 매퍼 사용

class DiaryDetailScreen extends StatefulWidget {
  final DiaryEntry entry;

  const DiaryDetailScreen({super.key, required this.entry});

  @override
  State<DiaryDetailScreen> createState() => _DiaryDetailScreenState();
}

class _DiaryDetailScreenState extends State<DiaryDetailScreen> {
  late TextEditingController _summaryController;
  late Box<DiaryEntry> diaryBox;

  final TextStyle _contentTextStyle = const TextStyle(
    fontSize: 16,
    height: 1.6,
    color: Colors.black87,
    fontWeight: FontWeight.w400,
  );

  @override
  void initState() {
    super.initState();
    _summaryController = TextEditingController(text: widget.entry.summary);
    diaryBox = Hive.box<DiaryEntry>('diaryBox');
  }

  void _saveEditedSummary() async {
    final updatedEntry = widget.entry.copyWith(summary: _summaryController.text);
    await diaryBox.put(widget.entry.id, updatedEntry);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('요약이 저장되었습니다.'),
        backgroundColor: Colors.teal.shade400,
      ),
    );
  }

  @override
  void dispose() {
    _summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final date = widget.entry.createdAt.toLocal().toString().split(' ')[0].replaceAll('-', '. ');
    final emotionColor = getColor(widget.entry.emotion);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Text(
          '기록 상세',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: emotionColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      '${getEmoji(widget.entry.emotion)} ${widget.entry.emotion}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: emotionColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            _buildSectionCard(
              title: '나의 원본 기록',
              child: Text(
                widget.entry.originalText,
                style: _contentTextStyle,
              ),
            ),
            const SizedBox(height: 25),

            _buildSectionCard(
              title: 'AI 요약 (수정 가능)',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _summaryController,
                    maxLines: null,
                    minLines: 3,
                    style: _contentTextStyle,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.teal.shade400, width: 1.5),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _saveEditedSummary,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('요약 수정 저장'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade500,
                      foregroundColor: Colors.white,
                      elevation: 4, // 드롭 쉐도우
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Card(
      elevation: 5, // 드롭 쉐도우
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.teal.shade600,
              ),
            ),
            const Divider(height: 25, thickness: 1.2),
            child,
          ],
        ),
      ),
    );
  }
}