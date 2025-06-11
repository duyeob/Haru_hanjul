import 'package:hive/hive.dart';

part 'diary_entry.g.dart';

@HiveType(typeId: 0)
class DiaryEntry extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String originalText;

  @HiveField(2)
  final String summary;

  @HiveField(3)
  final String emotion;

  @HiveField(4)
  final DateTime createdAt;

  DiaryEntry({
    required this.id,
    required this.originalText,
    required this.summary,
    required this.emotion,
    required this.createdAt,
  });

  /// ✅ copyWith 메서드 추가
  DiaryEntry copyWith({
    String? id,
    String? originalText,
    String? summary,
    String? emotion,
    DateTime? createdAt,
  }) {
    return DiaryEntry(
      id: id ?? this.id,
      originalText: originalText ?? this.originalText,
      summary: summary ?? this.summary,
      emotion: emotion ?? this.emotion,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
