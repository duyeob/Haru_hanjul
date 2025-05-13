import 'package:flutter/material.dart';

class EmotionInput extends StatelessWidget {
  final TextEditingController controller;

  const EmotionInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 5,
      decoration: const InputDecoration(
        hintText: "오늘 하루 있었던 감정을 자유롭게 적어보세요",
        border: OutlineInputBorder(),
      ),
    );
  }
}
