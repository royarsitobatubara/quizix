import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int progress;
  final int max;
  final double heightBar;

  const ProgressBar({
    super.key,
    required this.progress,
    required this.max,
    this.heightBar = 20,
  });

  @override
  Widget build(BuildContext context) {
    final double ratio = (progress / max).clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: heightBar,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(heightBar / 2),
          ),
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            tween: Tween(begin: 0, end: ratio),
            builder: (context, animatedRatio, _) {
              return FractionallySizedBox(
                widthFactor: animatedRatio,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.yellow, Colors.red],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(heightBar / 2),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
