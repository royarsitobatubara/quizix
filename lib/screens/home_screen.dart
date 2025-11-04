import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quizix/data/list_data.dart';
import 'package:quizix/data/user_provider.dart';
import 'package:quizix/utils/app_images.dart';
import 'package:quizix/widgets/info_daily_task.dart';
import 'package:quizix/widgets/game_item.dart';
import 'package:quizix/widgets/question_item.dart';
import 'package:quizix/widgets/rank_label.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = context.watch<UserProvider>().name;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- PROFILE HEADER ----------------
          GestureDetector(
            onTap: ()=>context.push('/profile'),
            child: ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                child: Image.asset(AppImages.defaultProfile, width: 30, height: 30,),
              ),
              title: Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Align(
                alignment: Alignment.centerLeft,
                child: RankLabel(fontSize: 12),
              ),

              trailing: IconButton(
                onPressed: ()=>context.push('/settings'),
                icon: const Icon(
                  Icons.settings,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // ---------------- DAILY TASK ----------------
          const InfoDailyTask(),

          const SizedBox(height: 25),

          // ---------------- GAMES SECTION ----------------
          Text(
            'games'.tr(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 10),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: gameList
                  .map((data) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GameItem(
                  nameMenu: data.title,
                  route: data.route,
                  image: data.image,
                ),
              ))
                  .toList(),
            ),
          ),

          const SizedBox(height: 20),

          // ---------------- QUIZ SECTION ----------------
          Text(
            "quiz".tr(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 10),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.9,
            ),
            itemCount: allQuestionPrimary.length,
            itemBuilder: (context, index) {
              final data = allQuestionPrimary[index];
              return QuestionItem(
                title: data.title,
                image: data.image,
                route: data.route,
                isPopular: true,
              );
            },
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
