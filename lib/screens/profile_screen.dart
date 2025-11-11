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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutScreen(
      nameScreen: 'profile',
      color: Colors.grey.shade50,
      child: SingleChildScrollView(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ----------------- Profile Header -----------------
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.lightBlue,
                      AppColors.lightBlue.withOpacity(0.8),
                      Colors.blue.shade400,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lightBlue.withOpacity(0.3),
                      offset: const Offset(0, 10),
                      blurRadius: 30,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    // Decorative circles
                    Positioned(
                      top: -50,
                      right: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -30,
                      left: -20,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                    ),

                    // Main content
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Column(
                          children: [
                            // Profile Picture with animation
                            TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0, end: 1),
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.elasticOut,
                              builder: (context, value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Colors.blue.shade100,
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 20,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Selector<UserProvider, String>(
                                        builder: (_, value, __) {
                                          return ClipOval(
                                            child: Image.asset(
                                              value,
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                        selector: (_, prov) => prov.profile,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 12),

                            // Edit button
                            TextButton.icon(
                              onPressed: () => context.push('/edit-photo'),
                              icon: const Icon(
                                Icons.camera_alt_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                              label: Text(
                                "edit".tr(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.2),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ----------------- Info Section -----------------
              SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Info cards
                      _buildInfoCard(
                        context,
                        'name',
                        '/edit-name',
                        Icons.person_rounded,
                        Icons.edit_rounded,
                        Colors.purple,
                      ),
                      const SizedBox(height: 15),

                      _buildInfoCard(
                        context,
                        'email',
                        '',
                        Icons.email_rounded,
                        null,
                        Colors.orange,
                      ),
                      const SizedBox(height: 15),

                      _buildInfoCard(
                        context,
                        'password',
                        '/edit-password',
                        Icons.lock_rounded,
                        Icons.edit_rounded,
                        Colors.red,
                      ),
                      const SizedBox(height: 15),

                      // Rank card
                      _buildRankCard(context),

                      const SizedBox(height: 30),

                      // Logout button with gradient
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.red.shade400,
                              Colors.red.shade600,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showPopUpInfo(
                              context: context,
                              title: 'are_you_sure_to_logout',
                              btn1: 'cancel',
                              btn2: 'yes',
                              image: AppImages.sure,
                              onClick: () async {
                                await UserPreferences.deleteUserStorage();
                                if (!context.mounted) return;
                                context.read<UserProvider>().loadAllData();
                                context.read<HistoryProvider>().loadAllHistory();
                                context.read<DataProvider>().loadAll();
                                context.go('/splash');
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          icon: const Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          label: Text(
                            'logout'.tr(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context,
      String label,
      String route,
      IconData leadingIcon,
      IconData? trailingIcon,
      Color iconColor,
      ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Leading icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              leadingIcon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),

          // Label and value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.tr(),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Selector<UserProvider, String>(
                  selector: (_, prov) {
                    switch (label) {
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
                  builder: (_, buildValue, __) {
                    return Text(
                      label == 'password' ? '••••••••' : buildValue,
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Trailing icon button
          if (trailingIcon != null)
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () => context.push(route),
                icon: Icon(
                  trailingIcon,
                  color: AppColors.lightBlue,
                  size: 22,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRankCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.amber.shade400,
            Colors.orange.shade500,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Rank info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.military_tech_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'rank'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                RankLabel(),
              ],
            ),
          ),

          // Points badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.local_fire_department_rounded,
                  size: 24,
                  color: Colors.deepOrange,
                ),
                const SizedBox(width: 8),
                Selector<UserProvider, int>(
                  builder: (_, value, __) => Text(
                    value.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                      fontSize: 20,
                    ),
                  ),
                  selector: (_, prov) => prov.point,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}