import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/diary_entry.dart';

class DiaryDetailScreen extends StatefulWidget {
  final DiaryEntry entry;

  const DiaryDetailScreen({super.key, required this.entry});

  @override
  State<DiaryDetailScreen> createState() => _DiaryDetailScreenState();
}

class _DiaryDetailScreenState extends State<DiaryDetailScreen> {
  late TextEditingController _summaryController;
  late Box<DiaryEntry> diaryBox;

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
      const SnackBar(content: Text('요약이 저장되었습니다.')),
    );

    setState(() {}); // UI 반영
  }

  @override
  void dispose() {
    _summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('일기 상세 보기')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('작성일: ${widget.entry.createdAt.toLocal().toString().split(' ')[0]}'),
              const SizedBox(height: 16),

              Text('내용:', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(widget.entry.originalText),
              const SizedBox(height: 16),

              Text('요약 (수정 가능):', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              TextField(
                controller: _summaryController,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              ElevatedButton.icon(
                onPressed: _saveEditedSummary,
                icon: const Icon(Icons.save),
                label: const Text('요약 저장하기'),
              ),

              const SizedBox(height: 24),
              Text('감정: ${widget.entry.emotion}'),
            ],
          ),
        ),
      ),
    );
  }
}
