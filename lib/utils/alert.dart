import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quizix/utils/app_colors.dart';

Future<void> showPopUpInfo({
  required BuildContext context,
  required String title,
  required String btn1,
  required String btn2,
  required String image,
  required VoidCallback onClick,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title.tr(), style: TextStyle(
          color: AppColors.deepBlue,
          fontWeight: FontWeight.bold
      ),),
      content: Image.asset(image, width: 150, height: 150,),
      actions: [
        ElevatedButton(
            onPressed: ()=>context.pop(),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8)
            ),
            child: Text(btn1.tr(), style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600
            ),)
        ),
        ElevatedButton(
            onPressed: ()=>onClick(),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8)
            ),
            child: Text(btn2.tr(), style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600
            ),)
        )
      ],
    ),
  );
}