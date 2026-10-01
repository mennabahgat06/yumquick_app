import 'package:flutter/material.dart';
import '../../../core/storage/onboarding_storage.dart';
import '../../../core/utils/app_colors.dart';
import '../../auth/presentation/welcome_view.dart';
import '../data/models/onboarding_item.dart';
import 'widgets/onboarding_page.dart';

/// 3 pages (Order For Food / Easy Payment / Fast Delivery), shown once.
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  final List<OnboardingItem> _pages = OnboardingItem.pages;
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await OnboardingStorage.setSeen();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeView()),
    );
  }

  void _next() {
    if (_currentPage == _pages.length - 1) {
      _finish();
    } else {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: _pages.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (_, index) => OnboardingPage(
              item: _pages[index],
              pageIndex: index,
              pageCount: _pages.length,
              onNext: _next,
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _finish,
                child: const Text(
                  'Skip  >',
                  style: TextStyle(color: AppColors.primaryOrange, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
