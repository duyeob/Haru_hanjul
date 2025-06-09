import 'package:flutter/material.dart';
import 'summary_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _controller = TextEditingController();

  void _goToSummaryScreen() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SummaryScreen(originalText: text),
        ),
      );
    }
  }

  void _goToDiaryList() {
    Navigator.pushNamed(context, '/list');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7), // 부드러운 배경색
      appBar: AppBar(
        title: const Text('일기 작성'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: '오늘 하루를 기록해보세요',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _goToSummaryScreen,
              icon: const Icon(Icons.auto_awesome),
              label: const Text('요약 및 감정 분석'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: _goToDiaryList,
              icon: const Icon(Icons.list),
              label: const Text('일기 목록 보기'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.teal,
                textStyle: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
