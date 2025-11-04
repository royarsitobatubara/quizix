import 'package:flutter/material.dart';
import 'package:quizix/screens/layout/layout_screen.dart';

class EditPictureScreen extends StatelessWidget {
  const EditPictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutScreen(
        nameScreen: 'edit_photo',
        child: Center(
          child: const Text(
            'Masih tahap pengembangan',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),
          ),
        ),
    );
  }
}
