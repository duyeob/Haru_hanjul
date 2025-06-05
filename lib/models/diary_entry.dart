import 'package:hive/hive.dart';

part 'diary_entry.g.dart';

@HiveType(typeId: 0)
class DiaryEntry extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String originalText;

  @HiveField(2)
  String summary;

  @HiveField(3)
  String emotion;

  @HiveField(4)
  DateTime createdAt;

  DiaryEntry({
    required this.id,
    required this.originalText,
    required this.summary,
    required this.emotion,
    required this.createdAt,
  });
}
