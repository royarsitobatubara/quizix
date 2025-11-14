import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:quizix/screens/layout/layout_screen.dart';
import 'package:quizix/utils/app_colors.dart';

class LayoutInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback handle;
  final String nameScreen;
  final String hintText;
  final String title;
  final String? msgError;

  const LayoutInput({
    super.key,
    required this.handle,
    required this.controller,
    required this.nameScreen,
    required this.hintText,
    required this.title,
    this.msgError,
  });

  @override
  State<LayoutInput> createState() => _LayoutInputState();
}

class _LayoutInputState extends State<LayoutInput>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _buttonController;
  late Animation<Offset> _titleSlideAnimation;
  late Animation<Offset> _textFieldSlideAnimation;
  late Animation<Offset> _buttonSlideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _buttonScaleAnimation;
  
  bool _isFocused = false;
  bool _isButtonPressed = false;

  @override
  void initState() {
    super.initState();
    
    // Main slide controller
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Button animation controller
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    // Staggered slide animations
    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
    ));

    _textFieldSlideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.2, 0.7, curve: Curves.easeOutCubic),
    ));

    _buttonSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeIn,
    ));

    _buttonScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeInOut,
    ));

    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void _handleButtonPress() {
    setState(() => _isButtonPressed = true);
    _buttonController.forward().then((_) {
      _buttonController.reverse().then((_) {
        setState(() => _isButtonPressed = false);
        widget.handle();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutScreen(
      nameScreen: widget.nameScreen,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Animated Title
            SlideTransition(
              position: _titleSlideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  widget.title.tr(),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Animated TextField with glow effect
            SlideTransition(
              position: _textFieldSlideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _isFocused
                        ? [
                            BoxShadow(
                              color: AppColors.deepBlue.withValues(alpha: 0.4),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                  child: TextField(
                    controller: widget.controller,
                    onTap: () => setState(() => _isFocused = true),
                    onTapOutside: (_) => setState(() => _isFocused = false),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.hintText.tr(),
                      hintStyle: TextStyle(
                        color: Colors.white.withValues(alpha: .4),
                        fontWeight: FontWeight.w400,
                      ),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: .1),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 18,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: .2),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: .2),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.deepBlue,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Animated Error Message
            if (widget.msgError != null)
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-0.1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _slideController,
                  curve: Curves.elasticOut,
                )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 4),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          widget.msgError!.tr(),
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 40),
            
            // Animated Button with scale effect
            SlideTransition(
              position: _buttonSlideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _buttonScaleAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.deepBlue.withValues(alpha: 0.3),
                          blurRadius: 15,
                          spreadRadius: 0,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _handleButtonPress,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deepBlue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "save_changes".tr(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          if (_isButtonPressed) ...[
                            const SizedBox(width: 12),
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}