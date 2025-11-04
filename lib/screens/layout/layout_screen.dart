import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quizix/utils/app_colors.dart';

class LayoutScreen extends StatelessWidget {
  final String nameScreen;
  final Widget child;
  final Color? color;
  const LayoutScreen({
    super.key,
    required this.nameScreen,
    required this.child,
    this.color = AppColors.lightBlue
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: AppColors.lightBlue,
        elevation: 0,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .35),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.white.withValues(alpha: .4), width: 1),
          ),
          child: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
        ),
        title: Text(
          nameScreen.tr(),
          style:const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: SafeArea(
        child: child,
      ),
    );
  }
}
