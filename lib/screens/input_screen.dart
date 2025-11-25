import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'summary_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();

  final TextStyle _diaryTextStyle = const TextStyle(
    fontSize: 16,
    height: 1.6,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _textFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _textFocusNode.dispose();
    super.dispose();
  }

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
    final today = DateFormat('yyyy. MM. dd. E', 'ko_KR').format(DateTime.now());
    final bool isInputEmpty = _controller.text.trim().isEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: Text(
          '오늘의 기록',
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
            icon: Icon(Icons.menu_book, color: Colors.grey.shade600),
            onPressed: _goToDiaryList,
            tooltip: '일기 목록',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              today,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.teal.shade400,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), // 드롭 쉐도우
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: TextField(
                  controller: _controller,
                  focusNode: _textFocusNode,
                  maxLines: null,
                  minLines: 15,
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  style: _diaryTextStyle,
                  decoration: InputDecoration(
                    hintText: '당신의 하루는 어땠나요? 마음껏 적어보세요...',
                    hintStyle: _diaryTextStyle.copyWith(color: Colors.grey.shade400),
                    border: InputBorder.none,
                    counterText: '${_controller.text.length} 자',
                    counterStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            child: ElevatedButton.icon(
              onPressed: isInputEmpty ? null : _goToSummaryScreen,
              icon: const Icon(Icons.flare_outlined, size: 24),
              label: Text(
                isInputEmpty ? '기록을 먼저 남겨주세요' : 'AI 요약 및 감정 분석',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isInputEmpty ? Colors.grey.shade300 : Colors.teal.shade500,
                foregroundColor: isInputEmpty ? Colors.grey.shade500 : Colors.white,
                elevation: 8, // 드롭 쉐도우
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                minimumSize: const Size(double.infinity, 50),
                textStyle: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}