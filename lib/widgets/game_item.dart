import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quizix/utils/app_colors.dart';

class GameItem extends StatelessWidget {
  final String nameMenu;
  final String route;
  final String image;
  const GameItem({super.key, required this.nameMenu, required this.route, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>context.push(route),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .35),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: Colors.white.withValues(alpha: .4), width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(image, width: 45, height: 45,)
            ),
          ),

          Text(nameMenu.tr(), style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),)
        ],
      )
    );
  }
}
