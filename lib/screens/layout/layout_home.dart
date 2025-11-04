import 'package:flutter/material.dart';
import 'package:quizix/screens/bookmarks_screen.dart';
import 'package:quizix/screens/history_screen.dart';
import 'package:quizix/screens/home_screen.dart';
import 'package:quizix/utils/app_colors.dart';

class LayoutHome extends StatefulWidget {
  const LayoutHome({super.key});

  @override
  State<LayoutHome> createState() => _LayoutHomeState();
}

class _LayoutHomeState extends State<LayoutHome>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late final PageController _pageController;

  final List<Widget> _pages = [
    HomeScreen(),
    BookmarksScreen(),
    HistoryScreen()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,

      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index){
            setState(()=>_selectedIndex = index);
          },
          children: _pages.map((e) => KeepAliveWidget(child: e)).toList(),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _selectedIndex = 1;
            _pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        elevation: 10,
        backgroundColor: _selectedIndex==1?AppColors.deepBlue:Colors.white,
        shape: const CircleBorder(),
        child: Icon(Icons.bookmark, color: _selectedIndex==1?AppColors.white:AppColors.deepBlue),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        color: Colors.white,
        child: SizedBox(
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navIcon(Icons.home, 0),
              const SizedBox(width: 10,),
              _navIcon(Icons.history, 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon, int index) {
    final isSelected = index == _selectedIndex;

    return GestureDetector(
      onTap: () => _onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.deepBlue : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: isSelected ? 28 : 24,
          color: isSelected ? Colors.white : AppColors.deepBlue,
        ),
      ),
    );
  }
}

/// menahan state biar tidak reset terus
class KeepAliveWidget extends StatefulWidget {
  final Widget child;
  const KeepAliveWidget({super.key, required this.child});

  @override
  State<KeepAliveWidget> createState() => _KeepAliveWidgetState();
}

class _KeepAliveWidgetState extends State<KeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
