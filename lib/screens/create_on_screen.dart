import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:quizix/screens/layout/layout_screen.dart';
import 'package:quizix/utils/app_colors.dart';

class CreateOnScreen extends StatelessWidget {
  const CreateOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutScreen(
        nameScreen: 'create_on',
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              builder: (context, value, child) => Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 50 * (1 - value)),
                  child: child,
                ),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.white.withValues(alpha: .4), width: 1),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today_rounded,
                        color: AppColors.white, size: 60),
                    const SizedBox(height: 15),
                    Text(
                      "create_on".tr(),
                      style: TextStyle(
                        color: AppColors.white.withValues(alpha: .9),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "20 October 2025",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Divider(color: Colors.white.withValues(alpha: .4), thickness: 1),
                    const SizedBox(height: 10),
                    Text(
                      "desc_create_on".tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .9),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
