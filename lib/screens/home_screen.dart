import 'package:flutter/material.dart';
import '../services/kobart_api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  bool _loading = false;

  Future<void> _summarizeText() async {
    setState(() => _loading = true);
    final summary = await KobartApiService.summarize(_controller.text);
    setState(() {
      _result = summary;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("하루 한줄")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "오늘 하루 있었던 감정을 자유롭게 적어보세요",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _summarizeText,
              child: const Text("감정 요약하기"),
            ),
            const SizedBox(height: 20),
            _loading
                ? const CircularProgressIndicator()
                : Text(_result, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
