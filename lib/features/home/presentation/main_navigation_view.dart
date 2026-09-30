import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import 'home_view.dart';
import 'menu_view.dart';
import '../../profile/presentation/profile_view.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeView(),
    MenuView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        decoration: const BoxDecoration(
          color: AppColors.primaryOrange,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home_outlined, 
                color: _currentIndex == 0 ? Colors.white : Colors.white60, size: 28),
              onPressed: () => setState(() => _currentIndex = 0),
            ),
            IconButton(
              icon: Icon(Icons.restaurant_menu, 
                color: _currentIndex == 1 ? Colors.white : Colors.white60, size: 28),
              onPressed: () => setState(() => _currentIndex = 1),
            ),
            IconButton(
              icon: Icon(Icons.person_outline, 
                color: _currentIndex == 2 ? Colors.white : Colors.white60, size: 28),
              onPressed: () => setState(() => _currentIndex = 2),
            ),
          ],
        ),
      ),
    );
  }
}