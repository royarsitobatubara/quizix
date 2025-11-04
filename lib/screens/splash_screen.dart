import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quizix/data/user_storage.dart';
import 'package:quizix/utils/app_colors.dart';
import 'package:quizix/utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> getStarted() async {
    await UserStorage.checkDailyReset();
    await Future.delayed(Duration(milliseconds: 3000));
    if(!mounted) return;
    context.go('/home');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStarted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      body: Center(
        child: Image.asset(AppImages.logo1, width: 100, height: 100,),
      ),
    );
  }
}
