import 'package:flutter/material.dart';
import 'package:haru_hanjul/screens/home_screen.dart';

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
