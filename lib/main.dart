import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/diary_entry.dart';
import 'screens/input_screen.dart';
import 'screens/diary_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DiaryEntryAdapter());
  await Hive.openBox<DiaryEntry>('diaryBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '하루 한줄',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/',
      routes: {
        '/': (_) => const InputScreen(),
        '/list': (_) => const DiaryListScreen(),
      },
    );
  }
}