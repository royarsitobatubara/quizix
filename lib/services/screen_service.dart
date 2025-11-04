import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quizix/data/database/db_helper.dart';
import 'package:quizix/data/question/biology.dart';
import 'package:quizix/data/question/informatics.dart';
import 'package:quizix/data/question/physics.dart';
import 'package:quizix/data/user_provider.dart';
import 'package:quizix/data/user_storage.dart';
import 'package:quizix/models/question_model.dart';
import 'package:quizix/utils/app_colors.dart';
import 'package:quizix/utils/app_images.dart';

// <=============================| QUESTION SCREEN |==============================>
List<QuestionModel> getQuestion(String category, String level) {
  final categoryMap = {
    "informatics": informaticsQuestion,
    "biology": biologyQuestion,
    "physics": physicsQuestion
  };
  final selectedCategory = categoryMap[category];
  if (selectedCategory == null) return [];

  return selectedCategory[level] ?? [];
}

// <==============================| SETTING SCREEN |==============================>
Future<void> deleteDataHandle(BuildContext context) async {
  try{
    showPopUpInfo(
      context: context,
      title: 'are_you_sure_you_want_to_delete_all_application_data?',
      btn1: 'cancel',
      btn2: 'yes',
      image: AppImages.sure,
      onClick: () async {
        await UserStorage.deleteUserStorage();
        await DbHelper.deleteDatabase();
        if(!context.mounted) return;
        context.read<UserProvider>().loadAll();
        context.pop();
      }
    );
    debugPrint('Success delete all data');
  }catch(e){
    debugPrint('Failed delete data: $e');
  }
}

// <=============================| EDIT NAME SCREEN |=============================>
  void saveNameHandle(BuildContext context, TextEditingController controller) async {
    final userProvider = context.read<UserProvider>();
    await userProvider.updateName(controller.text);
    if(!context.mounted) return;
    context.pop();
  }

// <===========================| DETAIL HISTORY SCREEN |==========================>

// <==================================| POP UP |==================================>
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

