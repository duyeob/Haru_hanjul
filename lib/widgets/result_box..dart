import 'package:flutter/material.dart';

class ResultBox extends StatelessWidget {
  final String resultText;

  const ResultBox({super.key, required this.resultText});

  @override
  Widget build(BuildContext context) {
    return resultText.isEmpty
        ? const SizedBox.shrink()
        : Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.indigo),
      ),
      child: Text(
        resultText,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
