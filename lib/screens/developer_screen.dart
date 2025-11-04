import 'package:flutter/material.dart';
import 'package:quizix/screens/layout/layout_screen.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  final List<Map<String, String>> developers = const [
    {"name": "Khairul Imam Harahap", "nim": "2312000110", "gender": "male"},
    {"name": "Mulia Aftidah", "nim": "2312000121", "gender": "female"},
    {"name": "Roy Arsito Batubara", "nim": "2312000132", "gender": "male"},
    {"name": "Yulina Febriani", "nim": "2312000134", "gender": "female"},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutScreen(
        nameScreen: 'developer',
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: developers.length,
            itemBuilder: (context, index) {
              final dev = developers[index];
              final isMale = dev['gender'] == 'male';

              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: .3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .2),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white,
                    child: Icon(
                      isMale ? Icons.male : Icons.female_rounded,
                      color: isMale ? Colors.blue[700] : Colors.pink[400],
                      size: 30,
                    ),
                  ),
                  title: Text(
                    dev['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    "NIM: ${dev['nim']}",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: .8),
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
    );
  }
}
