import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/diary_entry.dart';

class EmotionChart extends StatelessWidget {
  const EmotionChart({super.key});

  @override
  Widget build(BuildContext context) {
    final diaryBox = Hive.box<DiaryEntry>('diaryBox');
    final entries = diaryBox.values.toList();

    final counts = {'positive': 0, 'neutral': 0, 'negative': 0};
    for (var entry in entries) {
      counts[entry.emotion.toLowerCase()] = (counts[entry.emotion.toLowerCase()] ?? 0) + 1;
    }

    final sections = [
      PieChartSectionData(color: Colors.green, value: counts['positive']!.toDouble(), title: '😊'),
      PieChartSectionData(color: Colors.grey, value: counts['neutral']!.toDouble(), title: '😐'),
      PieChartSectionData(color: Colors.red, value: counts['negative']!.toDouble(), title: '😢'),
    ];

    return PieChart(PieChartData(sections: sections));
  }
}
