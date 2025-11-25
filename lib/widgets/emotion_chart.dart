import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';
import '../models/diary_entry.dart';
import '../utils/emotion_mapper.dart';

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

    final validEmotionEntries = emotionCounts.entries.where((e) => e.value > 0).toList();

    if (validEmotionEntries.isEmpty) {
      return Center(
        child: Text(
          '감정 데이터가 없습니다.',
          style: TextStyle(color: Colors.grey.shade500),
        ),
      );
    }

    final sections = validEmotionEntries.map((e) {
      final emoji = getEmoji(e.key);
      final entryColor = getColor(e.key);

      return PieChartSectionData(
        title: emoji,
        value: e.value.toDouble(),
        color: entryColor,
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(1, 1),
            ),
          ],
        ),
      );
    }).toList();

    // ⭐️ Column 구조 대신 AspectRatio만 반환하여 원래 위치를 복구합니다.
    return AspectRatio(
      aspectRatio: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0),
        child: PieChart(
          PieChartData(
            sections: sections,
            sectionsSpace: 3,
            centerSpaceRadius: 50,
            pieTouchData: PieTouchData(enabled: false),
          ),
        ),
      ),
    );
  }

// ⭐️ 범례 헬퍼 위젯은 해당 위젯에서 사용되지 않으므로 제거합니다.
// Widget _buildLegendItem(...) {...}
}