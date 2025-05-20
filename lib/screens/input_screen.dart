import 'package:flutter/material.dart';

class InputScreen extends StatefulWidget {
  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _loading = false;

  void _submitDiary() async {
    setState(() => _loading = true);

    final inputText = _controller.text;

    // TODO: 요약 요청 (api_service 연결 예정)

    await Future.delayed(Duration(seconds: 1)); // 테스트용 딜레이

    setState(() => _loading = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => Scaffold(
              appBar: AppBar(title: Text("요약 결과")),
              body: Center(child: Text("요약 결과가 여기에 표시됩니다")),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('감정 입력')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: "오늘 하루를 자유롭게 써주세요",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loading ? null : _submitDiary,
              icon: Icon(Icons.auto_fix_high),
              label: Text(_loading ? "요약 중..." : "AI 요약하기"),
            ),
          ],
        ),
      ),
    );
  }
}
