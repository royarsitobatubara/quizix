import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quizix/data/provider/user_provider.dart';
import 'package:quizix/data/user_preferences.dart';
import 'package:quizix/utils/app_colors.dart';
import 'package:quizix/utils/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void> getStarted() async {
    // await DbHelper.deleteDatabase();
    // await UserPreferences.deleteUserStorage();
    final isLogin = await UserPreferences.getDataLogin();
    final userId = await UserPreferences.getIdUser();
    await UserPreferences.checkDailyReset();
    await Future.delayed(const Duration(seconds: 3));
    if(isLogin == false || userId == null){
      debugPrint('isLogin: $isLogin, userId: $userId');
      if (!mounted) return;
      context.go('/login');
      return;
    }
    if (!mounted) return;
    debugPrint('isLogin: $isLogin, userId: $userId');
    context.read<UserProvider>().loadAllData();
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
