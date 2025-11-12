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

class _SettingScreenState extends State<SettingScreen> with TickerProviderStateMixin {
  bool music = true;
  bool effectMusic = true;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late List<Animation<double>> _cardAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();

    // Fade animation controller
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Slide animation controller
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Create staggered animations for each card
    _cardAnimations = List.generate(5, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _fadeController,
          curve: Interval(
            index * 0.15,
            0.5 + (index * 0.15),
            curve: Curves.easeOutCubic,
          ),
        ),
      );
    });

    _slideAnimations = List.generate(5, (index) {
      return Tween<Offset>(
        begin: const Offset(0.3, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: Interval(
            index * 0.15,
            0.5 + (index * 0.15),
            curve: Curves.easeOutCubic,
          ),
        ),
      );
    });

    // Start animations
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void toggleEffect() => setState(() => effectMusic = !effectMusic);

  Future<void> deleteDataHandle(BuildContext context) async {
    try {
      showPopUpInfo(
          context: context,
          title: 'are_you_sure_you_want_to_delete_all_application_data',
          btn1: 'cancel',
          btn2: 'yes',
          image: AppImages.sure,
          onClick: () async {
            await UserPreferences.deleteUserStorage();
            await DbHelper.deleteDatabase();
            if (!context.mounted) return;
            context.read<UserProvider>().loadAllData();
            context.read<HistoryProvider>().loadAllHistory();
            context.pop();
            context.go('/splash');
          });
      debugPrint('Success delete all data');
    } catch (e) {
      debugPrint('Failed delete data: $e');
    }
  }

  Future<void> deleteAccountHandle(BuildContext context) async {
    try {
      showPopUpInfo(
          context: context,
          title: 'are_you_sure_you_want_to_delete_this_account',
          btn1: 'cancel',
          btn2: 'yes',
          image: AppImages.sure,
          onClick: () async {
            await UserService.deleteUserById();
            await UserPreferences.deleteUserStorage();
            if (!context.mounted) return;
            context.read<UserProvider>().loadAllData();
            context.read<HistoryProvider>().loadAllHistory();
            context.pop();
            context.go('/splash');
          });
      debugPrint('Success delete all data');
    } catch (e) {
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
              // Account Card
              _buildAnimatedCard(
                index: 0,
                icon: Icons.person_outline,
                title: "account".tr(),
                children: [
                  buildMenuItem(context, '/edit-photo', 'edit_photo', Icons.photo_camera_outlined),
                  const SizedBox(height: 12),
                  buildMenuItem(context, '/edit-name', 'edit_name', Icons.edit_outlined),
                  const SizedBox(height: 12),
                  buildMenuItem(context, '/edit-password', 'edit_password', Icons.lock_outline),
                  const SizedBox(height: 12),
                  buildMenuItem(context, '/list-account', 'swap_account', Icons.swap_horiz),
                ],
              ),

              const SizedBox(height: 15),

              // Sounds Card
              _buildAnimatedCard(
                index: 1,
                icon: Icons.volume_up_outlined,
                title: "sounds".tr(),
                children: [
                  buildSwitchItem("music", dataProvider.backSound, () async {
                    final newValue = !dataProvider.backSound;
                    await UserPreferences.setDataBool(
                        key: 'backSound', value: newValue);
                    if (!context.mounted) return;
                    context.read<DataProvider>().loadBackSound();
                    if (newValue) {
                      AudioManager().playBackSound();
                    } else {
                      AudioManager().stopBackSound();
                    }
                  }),
                  const SizedBox(height: 12),
                  buildSwitchItem("effect", effectMusic, toggleEffect),
                ],
              ),

              const SizedBox(height: 15),

              // Language Card
              _buildAnimatedCard(
                index: 2,
                icon: Icons.language,
                title: "language".tr(),
                children: [
                  _buildLanguageSelector(context),
                ],
              ),

              const SizedBox(height: 15),

              // Info Card
              _buildAnimatedCard(
                index: 3,
                icon: Icons.info_outline,
                title: "info".tr(),
                children: [
                  buildMenuItem(context, '/create-on', 'create_on', Icons.calendar_today_outlined),
                  const SizedBox(height: 12),
                  buildMenuItem(context, '/developer', 'developer', Icons.code_outlined),
                  const SizedBox(height: 15),
                  _buildVersionRow(),
                ],
              ),

              const SizedBox(height: 15),

              // Storage Card
              _buildAnimatedCard(
                index: 4,
                icon: Icons.sd_storage_outlined,
                title: 'storage',
                children: [
                  _buildDangerButton(
                    context,
                    'delete_data'.tr(),
                    Icons.delete_outline,
                        () => deleteDataHandle(context),
                  ),
                  const SizedBox(height: 12),
                  _buildDangerButton(
                    context,
                    'delete_account'.tr(),
                    Icons.person_remove_outlined,
                        () => deleteAccountHandle(context),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ));
  }

  // Animated card wrapper
  Widget _buildAnimatedCard({
    required int index,
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return FadeTransition(
      opacity: _cardAnimations[index],
      child: SlideTransition(
        position: _slideAnimations[index],
        child: buildCard(
          icon: icon,
          title: title,
          children: children,
        ),
      ),
    );
  }

  // Enhanced card with gradient and glassmorphism
  Widget buildCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.25),
            Colors.white.withValues(alpha: 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(-5, -5),
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.3),
                      Colors.white.withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                child: Icon(icon, color: AppColors.white, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...children,
        ],
      ),
    );
  }

  // Enhanced menu item with icon and hover effect
  Widget buildMenuItem(BuildContext context, String path, String title, IconData leadingIcon) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.95 + (0.05 * value),
          child: child,
        );
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push(path),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(leadingIcon, size: 20, color: Colors.white.withValues(alpha: 0.9)),
                    const SizedBox(width: 12),
                    Text(
                      title.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.white.withValues(alpha: 0.95),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Enhanced switch with smooth animation
  Widget buildSwitchItem(String title, bool isOn, VoidCallback handle) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                isOn ? Icons.volume_up : Icons.volume_off,
                size: 20,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              const SizedBox(width: 12),
              Text(
                title.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.white.withValues(alpha: 0.95),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: handle,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: 52,
              height: 28,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: isOn
                      ? [Colors.greenAccent.shade400, Colors.green.shade600]
                      : [Colors.grey.shade400, Colors.grey.shade600],
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isOn ? Colors.greenAccent.shade400 : Colors.grey.shade400)
                        .withValues(alpha: 0.5),
                    offset: const Offset(0, 3),
                    blurRadius: 8,
                  ),
                ],
              ),
              alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Language selector with flag animation
  Widget _buildLanguageSelector(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push("/language"),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.translate, size: 20, color: Colors.white.withValues(alpha: 0.9)),
                  const SizedBox(width: 12),
                  Text(
                    "language".tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.white.withValues(alpha: 0.95),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.2),
                          Colors.white.withValues(alpha: 0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
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
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Version row with badge
  Widget _buildVersionRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, size: 20, color: Colors.white.withValues(alpha: 0.9)),
              const SizedBox(width: 12),
              Text(
                "version".tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.white.withValues(alpha: 0.95),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade400.withValues(alpha: 0.6),
                  Colors.blue.shade600.withValues(alpha: 0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade400.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              "1.1.0",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Danger button with warning style
  Widget _buildDangerButton(
      BuildContext context,
      String title,
      IconData icon,
      VoidCallback onTap,
      ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red.shade400.withValues(alpha: 0.3),
                Colors.red.shade600.withValues(alpha: 0.2),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.red.shade300.withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 20, color: Colors.red.shade100),
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.red.shade50,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.warning_amber_rounded,
                size: 20,
                color: Colors.red.shade200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}