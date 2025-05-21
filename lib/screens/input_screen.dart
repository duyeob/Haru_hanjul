import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/diary_entry.dart';
import 'summary_screen.dart';


class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _controller = TextEditingController();
  final _uuid = Uuid();

  void _goToSummary() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('일기 내용을 입력해주세요')),
      );
      return;
    }

    // UUID로 id 생성
    final diaryId = _uuid. v4();

    // 임시로 감정과 요약은 빈 문자열로 전달 (나중에 요약, 감정 분석 API 결과로 교체)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SummaryScreen(
          diaryId: diaryId,
          originalText: text,
          summary: '요약 중...', // 요약 처리 로직 넣기 전 임시 문구
          emotion: '알 수 없음', // 감정 분석 결과로 변경 예정
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('일기 입력')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 8,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '오늘의 감정을 기록해보세요',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _goToSummary,
              child: Text('요약 및 감정 분석'),
            ),
          ],
        ),
      ),
    );
  }
}
