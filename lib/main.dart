import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/theme/app_theme.dart';
import 'package:piggy_bank/features/learning_process/presentation/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleManager())
      ],
      child: Consumer<LocaleManager>(
        builder: (context,localeManager,child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: '',
            theme: AppTheme.themeMode,
            locale: localeManager.currentLocale,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('tr')
            ],
            home: const HomePage(),
          );
        },
      )
    );
  }
}
