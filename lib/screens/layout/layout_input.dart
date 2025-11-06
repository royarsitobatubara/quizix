import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:quizix/screens/layout/layout_screen.dart';
import 'package:quizix/utils/app_colors.dart';

class LayoutInput extends StatelessWidget {

  final TextEditingController controller;
  final VoidCallback handle;
  final String nameScreen;
  final String hintText;
  final String title;
  final String? msgError;

  const LayoutInput({
    super.key,
    required this.handle,
    required this.controller,
    required this.nameScreen,
    required this.hintText,
    required this.title,
    this.msgError
  });


  @override
  Widget build(BuildContext context) {
    return LayoutScreen(
      nameScreen: nameScreen,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title.tr(),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                hintText: hintText.tr(),
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: .4)),
                filled: true,
                fillColor: Colors.white.withValues(alpha: .1),
                contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                      color: Colors.white.withValues(alpha: .2)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                      color: Colors.white.withValues(alpha: .2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                  BorderSide(color: AppColors.white.withValues(alpha: .6)),
                ),
              ),
            ),
            if (msgError != null)
              Text(msgError!.tr(), style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => handle(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.deepBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                child: Text(
                  "save_changes".tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
