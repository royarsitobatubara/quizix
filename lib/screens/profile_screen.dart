import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quizix/data/provider/data_provider.dart';
import 'package:quizix/data/provider/history_provider.dart';
import 'package:quizix/data/provider/user_provider.dart';
import 'package:quizix/data/user_preferences.dart';
import 'package:quizix/screens/layout/layout_screen.dart';
import 'package:quizix/utils/alert.dart';
import 'package:quizix/utils/app_colors.dart';
import 'package:quizix/utils/app_images.dart';
import 'package:quizix/widgets/rank_label.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .5),
                      shape: BoxShape.circle,
                    ),
                    child: Selector<UserProvider, String>(
                        builder: (_, value, _){
                          return ClipOval(child: Image.asset(value, width: 80, height: 80,),);
                    }, selector: (_, prov)=> prov.profile),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildInfoProfile(context, 'name', '/edit-name', Icons.edit),
                  buildInfoProfile(context, 'email', '', null),
                  buildInfoProfile(context, 'password', '/edit-password', Icons.edit),
                  buildRankInfo(context),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: (){
                      showPopUpInfo(context: context, title: 'are_you_sure_to_logout', btn1: 'cancel', btn2: 'yes', image: AppImages.sure, onClick: ()async{
                        await UserPreferences.deleteUserStorage();
                        if(!context.mounted) return;
                        context.read<UserProvider>().loadAllData();
                        context.read<HistoryProvider>().loadAllHistory();
                        context.read<DataProvider>().loadAll();
                        context.go('/splash');
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent
                    ),
                    child: Text('logout'.tr(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                  )
                ],
              )
            )

          ],
        ),
      )
    );
  }

  Widget buildInfoProfile(BuildContext context, String label,String route, IconData? icon){
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
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
              Selector<UserProvider, String>(
                selector: (_, prov){
                  switch(label){
                    case 'name':
                      return prov.name;
                    case 'email':
                      return prov.email;
                    case 'point':
                      return prov.point.toString();
                    default:
                      return label;
                  }
                },
                builder: (_, buildValue, _){
                  return Text(label=='password'? '*******':buildValue, style: TextStyle(
                      color: AppColors.lightBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                  ),);
                },
              )
            ],
          ),
          if(icon != null)
            IconButton(onPressed: ()=>context.push(route), icon: Icon(icon, size: 25, color: AppColors.lightBlue,))
        ],
      ),
    );
  }

  Widget buildRankInfo(BuildContext context){
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
                Selector<UserProvider, int>(
                  builder: (_, value, _)=>Text(value.toString(), style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.orange,
                      fontSize: 18
                  ),),
                  selector: (_, prov)=>prov.point)
              ],
            ),
          )
        ],
      ),
    );
  }
}
