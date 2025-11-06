
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizix/app_routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:quizix/data/provider/data_provider.dart';
import 'package:quizix/data/provider/history_provider.dart';
import 'package:quizix/data/provider/user_provider.dart';
import 'package:quizix/data/user_preferences.dart';
import 'package:quizix/services/audio_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final savedLang = await UserPreferences.getLanguage();
  final initialLocale = Locale(savedLang);
  final userProvider = DataProvider();
  await userProvider.loadBackSound();
  if(userProvider.backSound){
    AudioManager().playBackSound();
  }

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('id'),
        Locale('zh'),
        Locale('ja'),
      ],
      path: 'assets/langs',
      fallbackLocale: initialLocale,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => DataProvider()),
          ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: "Quizix",
      routerConfig: AppRoutes().router,
    );
  }
}
