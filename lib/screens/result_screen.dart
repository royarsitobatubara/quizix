import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatelessWidget {
  final int correct;
  final int wrong;
  final int score;

  const ResultScreen({
    super.key,
    required this.correct,
    required this.wrong,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Benar: $correct', style: const TextStyle(color: Colors.white, fontSize: 20)),
            Text('Salah: $wrong', style: const TextStyle(color: Colors.white, fontSize: 20)),
            Text('Skor: $score%', style: const TextStyle(color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
