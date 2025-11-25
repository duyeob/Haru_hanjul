import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
import '../models/diary_entry.dart';
import '../services/api_service.dart';
import '../utils/emotion_mapper.dart';

class SummaryScreen extends StatefulWidget {
  final String originalText;
  const SummaryScreen({super.key, required this.originalText});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  String summary = '';
  String emotion = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _processEntry();
  }

  Future<void> _processEntry() async {
    try {
      final result = await ApiService.analyzeText(widget.originalText);
      setState(() {
        summary = result['summary']!;
        emotion = result['emotion']!;
        isLoading = false;
      });

      final newEntry = DiaryEntry(
        id: const Uuid().v4(),
        originalText: widget.originalText,
        summary: summary,
        emotion: emotion,
        createdAt: DateTime.now(),
      );
      final box = Hive.box<DiaryEntry>('diaryBox');
      await box.put(newEntry.id, newEntry);
    } catch (e) {
      setState(() {
        isLoading = false;
        summary = '분석 중 오류가 발생했습니다.';
        emotion = 'Unknown';
      });
    }
  }

  void _goToDiaryList() {
    Navigator.pushReplacementNamed(context, '/list');
  }

  @override
  Widget build(BuildContext context) {
    final emoji = getEmoji(emotion);
    final color = getColor(emotion);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Text(
          '분석 결과',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: isLoading
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.teal.shade400),
            const SizedBox(height: 20),
            Text(
              '당신의 감정을 분석 중입니다...',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
          ],
        )
            : SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 10, // 드롭 쉐도우
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '오늘의 핵심 감정',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 12),
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: color.withOpacity(0.15),
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        emotion,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const Divider(height: 35, indent: 20, endIndent: 20),
                      Text(
                        '하루 요약',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        summary,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _goToDiaryList,
                icon: const Icon(Icons.menu_book, size: 24),
                label: const Text(
                  '일기 목록으로',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade500,
                  foregroundColor: Colors.white,
                  elevation: 6, // 드롭 쉐도우
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}