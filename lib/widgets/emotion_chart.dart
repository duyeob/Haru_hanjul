import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';
import '../models/diary_entry.dart';
import '../utils/emotion_mapper.dart'; // 이 경로는 상황에 맞게 수정

class EmotionChart extends StatelessWidget {
  const EmotionChart({super.key});

  @override
  Widget build(BuildContext context) {
    final diaryBox = Hive.box<DiaryEntry>('diaryBox');
    final entries = diaryBox.values.toList();
    final emotionCounts = <String, int>{};

    for (var entry in entries) {
      final e = entry.emotion.toLowerCase();
      emotionCounts[e] = (emotionCounts[e] ?? 0) + 1;
    }

    final sections = emotionCounts.entries.map((e) {
      return PieChartSectionData(
        title: e.key,
        value: e.value.toDouble(),
        color: getColor(e.key), // 수정된 부분
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PieChart(
        PieChartData(
          sections: sections,
          sectionsSpace: 4,
          centerSpaceRadius: 32,
        ),
      ),
    );
  }
}
