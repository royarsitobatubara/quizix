import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quizix/data/user_provider.dart';
import 'package:quizix/data/user_storage.dart';
import 'package:quizix/screens/layout/layout_screen.dart';
import 'package:quizix/utils/app_images.dart';

class EditPictureScreen extends StatefulWidget {
  const EditPictureScreen({super.key});

  @override
  State<EditPictureScreen> createState() => _EditPictureScreenState();
}

class _EditPictureScreenState extends State<EditPictureScreen> {
  int? _currentIndex;

  Future<void> _editPhotoHandle() async {
    try {
      await UserStorage.setDataString(
          key: 'profile',
          value: AppImages.listProfile[_currentIndex!]
      );
      if(!mounted) return;
      context.read<UserProvider>().loadProfile();
      context.pop();
    } catch(e) {
      debugPrint('Terjadi kesalahan pada _editPhotoHandle: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return LayoutScreen(
        nameScreen: 'edit_photo',
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1
                  ),
                  itemCount: AppImages.listProfile.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: ()=>setState(()=>_currentIndex = index),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: _currentIndex == index? Colors.greenAccent : Colors.white.withValues(alpha: .5),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                          boxShadow: [
                            BoxShadow(color: _currentIndex == index? Colors.white:Colors.black.withValues(alpha: .3), offset: const Offset(0, 5), blurRadius: 5)
                          ]
                        ),
                        child: ClipOval(
                          child: Image.asset(AppImages.listProfile[index]),
                        ),
                      ),
                    );
                  }
                ),
              ),
              ElevatedButton(
                onPressed: ()=>_editPhotoHandle(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent
                ),
                child: Text('submit'.tr(), style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),)
              )
            ],
          ),
        )
    );
  }
}
