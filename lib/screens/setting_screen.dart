
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:quizix/data/database/db_helper.dart';
import 'package:quizix/data/database/user_service.dart';
import 'package:quizix/data/provider/data_provider.dart';
import 'package:quizix/data/provider/history_provider.dart';
import 'package:quizix/data/provider/user_provider.dart';
import 'package:quizix/data/user_preferences.dart';
import 'package:quizix/screens/layout/layout_screen.dart';
import 'package:quizix/services/audio_manager.dart';
import 'package:quizix/utils/alert.dart';
import 'package:quizix/utils/app_colors.dart';
import 'package:quizix/utils/app_images.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool music = true;
  bool effectMusic = true;

  void toggleEffect() => setState(() => effectMusic = !effectMusic);

  Future<void> deleteDataHandle(BuildContext context) async {
    try{
      showPopUpInfo(
          context: context,
          title: 'are_you_sure_you_want_to_delete_all_application_data',
          btn1: 'cancel',
          btn2: 'yes',
          image: AppImages.sure,
          onClick: () async {
            await UserPreferences.deleteUserStorage();
            await DbHelper.deleteDatabase();
            if(!context.mounted) return;
            context.read<UserProvider>().loadAllData();
            context.read<HistoryProvider>().loadAllHistory();
            context.pop();
            context.go('/splash');
          }
      );
      debugPrint('Success delete all data');
    }catch(e){
      debugPrint('Failed delete data: $e');
    }
  }

  Future<void> deleteAccountHandle(BuildContext context) async {
    try{
      showPopUpInfo(
          context: context,
          title: 'are_you_sure_you_want_to_delete_this_account',
          btn1: 'cancel',
          btn2: 'yes',
          image: AppImages.sure,
          onClick: () async {
            await UserService.deleteUserById();
            await UserPreferences.deleteUserStorage();
            if(!context.mounted) return;
            context.read<UserProvider>().loadAllData();
            context.read<HistoryProvider>().loadAllHistory();
            context.pop();
            context.go('/splash');
          }
      );
      debugPrint('Success delete all data');
    }catch(e){
      debugPrint('Failed delete data: $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final dataProvider = Provider.of<DataProvider>(context);

    return LayoutScreen(
        nameScreen: 'settings',
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildCard(
                icon: Icons.person_outline,
                title: "account".tr(),
                children: [
                  buildMenuItem(context, '/edit-photo', 'edit_photo'),
                  const SizedBox(height: 8),
                  buildMenuItem(context, '/edit-name', 'edit_name'),
                  const SizedBox(height: 8),
                  buildMenuItem(context, '/edit-password', 'edit_password'),
                  const SizedBox(height: 8),
                  buildMenuItem(context, '/list-account', 'swap_account'),
                ],
              ),

              const SizedBox(height: 15),
              buildCard(
                icon: Icons.volume_up_outlined,
                title: "sounds".tr(),
                children: [
                  buildSwitchItem("music", dataProvider.backSound, ()async{
                    final newValue = !dataProvider.backSound;
                    await UserPreferences.setDataBool(key: 'backSound', value: newValue);
                    if(!context.mounted)return;
                    context.read<DataProvider>().loadBackSound();
                    if (newValue) {
                      AudioManager().playBackSound();
                    } else {
                      AudioManager().stopBackSound();
                    }
                  }),
                  const SizedBox(height: 8),
                  buildSwitchItem("effect", effectMusic, toggleEffect),
                ],
              ),

              const SizedBox(height: 15),
              buildCard(
                icon: Icons.language,
                title: "language".tr(),
                children: [
                  GestureDetector(
                    onTap: () => context.push("/language"),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("language".tr(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                        Row(
                          children: [
                            Text(
                              context.locale.languageCode == 'en'
                                  ? "🇺🇸 EN"
                                  : context.locale.languageCode == 'id'
                                  ? "🇮🇩 ID"
                                  : context.locale.languageCode == 'zh'
                                  ? "🇨🇳 中文"
                                  : context.locale.languageCode == 'ja'
                                  ? "🇯🇵 日本語"
                                  : "🌍",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_ios_rounded,
                                size: 16, color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),

              const SizedBox(height: 15),
              buildCard(
                icon: Icons.info_outline,
                title: "info".tr(),
                children: [
                  buildMenuItem(context, '/create-on', 'create_on'),
                  const SizedBox(height: 8),
                  buildMenuItem(context, '/developer', 'developer'),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("version".tr(),
                          style:const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15)),
                      Text("1.1.0",
                          style:const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 15),
              buildCard(
                icon: Icons.sd_storage_outlined,
                title: 'storage',
                children: [
                  GestureDetector(
                    onTap: ()async => await deleteDataHandle(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('delete_data'.tr(),
                            style:
                            const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                        const Icon(Icons.delete, size: 16,),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: ()async => await deleteAccountHandle(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('delete_account'.tr(),
                            style:
                            const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                        const Icon(Icons.delete, size: 16,),
                      ],
                    ),
                  )
                ]
              )
            ],
          ),
        )
    );
  }

  // 🧱 Reusable card container
  Widget buildCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.white, size: 30),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  // ⚙️ Menu with navigation
  Widget buildMenuItem(BuildContext context, String path, String title) {
    return GestureDetector(
      onTap: () => context.push(path),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title.tr(),
              style:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        ],
      ),
    );
  }

  // 🎵 Switch toggle
  Widget buildSwitchItem(String title, bool isOn, VoidCallback handle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title.tr(),
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
        GestureDetector(
          onTap: handle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 48,
            height: 26,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isOn ? Colors.greenAccent.shade400 : Colors.grey.shade400,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:  0.15),
                  offset: const Offset(0, 3),
                  blurRadius: 4,
                ),
              ],
            ),
            alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
