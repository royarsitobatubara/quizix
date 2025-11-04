import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quizix/utils/app_colors.dart';

class GuestNumberGame extends StatefulWidget {
  const GuestNumberGame({super.key});

  @override
  State<GuestNumberGame> createState() => _GuestNumberGameState();
}

class _GuestNumberGameState extends State<GuestNumberGame> {
  final TextEditingController _controller = TextEditingController();
  late int _targetNumber;
  String _message = "Tebak angka antara 1 - 100";
  int _attempts = 0;

  @override
  void initState() {
    super.initState();
    _generateNumber();
  }

  void _generateNumber() {
    final random = Random();
    _targetNumber = random.nextInt(10) + 1;
    _attempts = 0;
    _message = "Tebak angka antara 1 - 10";
    _controller.clear();
    setState(() {});
  }

  void _checkGuess() {
    if (_controller.text.isEmpty) return;

    final guess = int.tryParse(_controller.text);
    if (guess == null) {
      setState(() {
        _message = "Masukkan angka valid!";
      });
      return;
    }

    _attempts++;

    if (guess == _targetNumber) {
      setState(() {
        _message = "🎉 Benar! Angkanya $_targetNumber. Percobaan: $_attempts kali.";
      });
    } else if (guess < _targetNumber) {
      setState(() {
        _message = "Terlalu kecil 😅";
      });
    } else {
      setState(() {
        _message = "Terlalu besar 😬";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.lightBlue,
        leading: IconButton(
          onPressed: ()=>context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 26, color: Colors.white),
        ),
        title: const Text(
          'Guess the Number',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Masukkan tebakanmu",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkGuess,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightBlue,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Tebak", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: _generateNumber,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.lightBlue, width: 2),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Main Lagi", style: TextStyle(color: AppColors.lightBlue, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
