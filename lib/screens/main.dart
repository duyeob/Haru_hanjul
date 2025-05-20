import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @overrideimport 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(HaruApp());
}

class HaruApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '하루한줄',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Pretendard',
      ),
      home: HomeScreen(),
    );
  }
}

  Widget build(BuildContext context) {
    return MaterialApp(
      title: '하루한줄 감정일기',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomeScreen(),
    );
  }
}
