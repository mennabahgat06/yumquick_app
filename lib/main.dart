import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/network/auth_interceptor.dart';
import 'core/storage/language_storage.dart';
import 'core/storage/onboarding_storage.dart';
import 'core/storage/token_storage.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_navigator.dart';
import 'features/auth/presentation/welcome_view.dart';
import 'features/home/presentation/main_navigation_view.dart';
import 'features/onboarding/presentation/onboarding_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LanguageStorage.load();
  final isLoggedIn = await TokenStorage.isLoggedIn();
  final onboardingSeen = await OnboardingStorage.isSeen();

  // First screen: logged in -> Home, first launch -> Onboarding, else -> Welcome.
  final Widget startScreen = isLoggedIn
      ? const MainNavigationView()
      : onboardingSeen
          ? const WelcomeView()
          : const OnboardingView();

  // Token expired / invalid (401) -> back to Welcome.
  AuthInterceptor.onSessionExpired = () {
    AppNavigator.key.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const WelcomeView()),
      (route) => false,
    );
  };

  runApp(YumQuickApp(startScreen: startScreen));
}

class YumQuickApp extends StatelessWidget {
  final Widget startScreen;

  const YumQuickApp({super.key, required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: LanguageStorage.localeNotifier,
      builder: (context, locale, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'YumQuick',
          navigatorKey: AppNavigator.key,
          locale: locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundWhite,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryOrange),
            useMaterial3: true,
          ),
          home: startScreen,
        );
      },
    );
  }
}
