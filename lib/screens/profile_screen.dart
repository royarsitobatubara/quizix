import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quizix/data/user_provider.dart';
import 'package:quizix/screens/layout/layout_screen.dart';
import 'package:quizix/utils/app_colors.dart';
import 'package:quizix/utils/app_images.dart';
import 'package:quizix/widgets/rank_label.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userName = context.watch<UserProvider>().name;
    final point = context.watch<UserProvider>().point;
    return LayoutScreen(
      nameScreen: 'profile',
      color: AppColors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------- profile -----------------
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                boxShadow: [BoxShadow(
                  color: Colors.black26,
                  offset: const Offset(0, 8),
                  blurRadius: 20
                )]
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(AppImages.defaultProfile, width: 80, height: 80,),
                  ),
                  TextButton(onPressed: ()=>context.push('/edit-photo'), child: Text("edit".tr(), style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12
                  ),))
                ],
              ),
            ),

            // ----------------- info -----------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoProfile(context, 'name', userName, '/edit-name', null),
                  buildRankInfo(context,point)
                ],
              )
            )

          ],
        ),
      )
    );
  }

  Widget buildInfoProfile(BuildContext context, String label, String value, String route, IconData? icon){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label.tr(), style: TextStyle(
                color: AppColors.lightBlue,
                fontWeight: FontWeight.w700,
              ),),
              Text(value, style: TextStyle(
                  color: AppColors.lightBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 22
              ),)
            ],
          ),
          IconButton(onPressed: ()=>context.push(route), icon: Icon(icon ?? Icons.edit, size: 25, color: AppColors.lightBlue,))
        ],
      ),
    );
  }

  Widget buildRankInfo(BuildContext context, int point){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('rank'.tr(), style: TextStyle(
                color: AppColors.lightBlue,
                fontWeight: FontWeight.w700,
              ),),
              RankLabel()
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(50)
            ),
            child: Row(
              children: [
                Icon(Icons.local_fire_department_rounded, size: 25, color: Colors.deepOrange,),
                Text(point.toString(), style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.orange,
                  fontSize: 18
                ),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
