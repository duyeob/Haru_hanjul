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
        summary = '에러 발생';
        emotion = 'Unknown';
      });
    }
  }

  void _goToDiaryList() {
    Navigator.pushNamed(context, '/list');
  }

  @override
  Widget build(BuildContext context) {
    final emoji = getEmoji(emotion);
    final color = getColor(emotion);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text('분석 결과'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        '요약 결과',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        summary,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  const Text(
                    '감정 분석',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: color.withOpacity(0.2),
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    emotion.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: _goToDiaryList,
                icon: const Icon(Icons.list),
                label: const Text('일기 목록 보기'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
