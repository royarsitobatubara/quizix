import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizix/data/user_provider.dart';

class RankLabel extends StatelessWidget {
  final double? fontSize;
  RankLabel({super.key, this.fontSize = 18});

  final colorMap = {
    'beginner': Colors.greenAccent,
    'intermediate': Colors.orangeAccent,
    'expert': Colors.redAccent
  };

  String getRank(int point) {
    if(point == 0 || point < 1000){
      return 'beginner';
    }else if(point >= 1000 || point < 2000 ){
      return 'intermediate';
    }else if(point >= 2000 ){
      return 'expert';
    }
    return 'beginner';
  }

  @override
  Widget build(BuildContext context) {
    final point = context.read<UserProvider>().point;
    return Container(
      constraints: const BoxConstraints(
        minWidth: 0,
      ),

      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: colorMap[getRank(point)] ?? Colors.greenAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(getRank(point).tr(), style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: fontSize
      ),),
    );
  }
}
