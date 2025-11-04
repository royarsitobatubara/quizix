import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:quizix/data/user_storage.dart';
import 'package:quizix/screens/layout/layout_screen.dart';
import 'package:quizix/utils/app_colors.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String currentLang = "";

  @override
  void initState() {
    super.initState();
    initLang();
  }

  Future<void> initLang() async {
    String savedLang = await UserStorage.getLanguage();
    setState(() {
      currentLang = savedLang.isEmpty ? "en" : savedLang;
    });
    if(!mounted) return;
    context.setLocale(Locale(currentLang.toLowerCase()));
  }

  void switchLanguage(String lang) async {
    setState(() {
      currentLang = lang;
      context.setLocale(Locale(lang.toLowerCase()));
    });

    await UserStorage.saveLanguage(lang.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutScreen(
      nameScreen: 'language',
      child: Stack(
        children: [
          // 🌈 Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.lightBlue.withValues(alpha: .8),
                  AppColors.deepBlue.withValues(alpha: .6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 🌫️ Blur Layer
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(color: Colors.transparent),
          ),

          // 🧊 Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "choose_your_language".tr(),
                    style:const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  buildLangOption("id", "🇮🇩 Bahasa Indonesia"),
                  const SizedBox(height: 16),
                  buildLangOption("en", "🇺🇸 English"),
                  const SizedBox(height: 16),
                  buildLangOption("zh", "🇨🇳 中文 (China)"),
                  const SizedBox(height: 16),
                  buildLangOption("ja", "🇯🇵 日本語"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLangOption(String code, String title) {
    bool selected = currentLang == code;
    return GestureDetector(
      onTap: () => switchLanguage(code),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        width: double.infinity,
        decoration: BoxDecoration(
          color: selected
              ? Colors.white.withValues(alpha: .25)
              : Colors.white.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected ? Colors.white12 : Colors.white.withValues(alpha: .2),
              width: 1.5),
          boxShadow: selected
              ? [
            BoxShadow(
              color: Colors.white.withValues(alpha: .4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ]
              : [],
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              color: selected ? Colors.greenAccent : Colors.white70,
              size: 28,
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: TextStyle(
                color: selected ? Colors.white : Colors.white.withValues(alpha: .8),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.language,
              color: selected ? Colors.white : Colors.white54,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
