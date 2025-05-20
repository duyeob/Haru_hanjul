import 'package:flutter/material.dart';
import 'input_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('하루한줄')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit, size: 100, color: Colors.deepPurple),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => InputScreen()),
                );
              },
              child: Text("오늘의 감정 기록하기"),
            ),
          ],
        ),
      ),
    );
  }
}
