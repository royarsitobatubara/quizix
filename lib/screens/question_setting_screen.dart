import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quizix/data/list_data.dart';
import 'package:quizix/utils/app_colors.dart';
import 'package:quizix/utils/app_images.dart';

class QuestionSettingScreen extends StatefulWidget {
  final String lesson;
  const QuestionSettingScreen({super.key, required this.lesson});

  @override
  State<QuestionSettingScreen> createState() => _QuestionSettingScreenState();
}

class _QuestionSettingScreenState extends State<QuestionSettingScreen>
    with SingleTickerProviderStateMixin {
  String selectedLevel = "easy";

  @override
  Widget build(BuildContext context) {
    final data = allQuestion.firstWhere(
          (item) => item.route == '/question/${widget.lesson.toLowerCase()}',
    );

    final String lessonImage = data.image;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
        ),
        centerTitle: true,
        title: Text(
          "choose_level".tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.deepBlue.withValues(alpha: .9),
              AppColors.lightBlue.withValues(alpha: .9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            image: AssetImage(AppImages.logo1),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // LESSON CARD
                _buildLessonCard(lessonImage),

                const SizedBox(height: 40),

                // SELECT LEVEL
                Text(
                  "select_difficulty".tr(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildLevelButton("easy", Colors.greenAccent),
                    _buildLevelButton("medium", Colors.orangeAccent),
                    _buildLevelButton("hard", Colors.redAccent),
                  ],
                ),

                const Spacer(),

                // START BUTTON
                AnimatedScale(
                  scale: 1.05,
                  duration: const Duration(milliseconds: 600),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 6,
                    ),
                    onPressed: () {
                      context.push('/question/${widget.lesson.toLowerCase()}/$selectedLevel');
                      debugPrint('/question/${widget.lesson.toLowerCase()}/$selectedLevel');
                    },
                    child: Text(
                      'start_quiz'.tr(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLessonCard(String lessonImage) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: .25),
            Colors.white.withValues(alpha: .05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: .2)),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(lessonImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.lesson.tr(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfo(icon: Icons.timer, desc: '60s'),
                    _buildInfo(icon: Icons.help, desc: '10 Qs'),
                    _buildInfo(icon: Icons.star, desc: '100 pts'),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo({required IconData icon, required String desc}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .25),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.yellowAccent, size: 22),
        ),
        const SizedBox(height: 5),
        Text(
          desc,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildLevelButton(String level, Color color) {
    final bool isSelected = selectedLevel == level;

    return GestureDetector(
      onTap: () {
        setState(() => selectedLevel = level);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
            colors: [color.withValues(alpha: .9), color.withValues(alpha: .6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : LinearGradient(
            colors: [
              Colors.white.withValues(alpha: .2),
              Colors.white.withValues(alpha: .1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: .7), width: 2),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: color.withValues(alpha: .5),
              blurRadius: 12,
              spreadRadius: 1,
            ),
          ]
              : [],
        ),
        child: Text(
          level.tr(), // ← tampilkan terjemahan, tapi simpan key Inggris
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
