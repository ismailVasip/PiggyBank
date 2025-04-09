import 'package:flutter/material.dart';
import 'package:piggy_bank/core/localization/locale_manager.dart';
import 'package:piggy_bank/core/theme/app_pallete.dart';
import 'package:piggy_bank/core/theme/app_text_theme.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => Settings());
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final localeManager = Provider.of<LocaleManager>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 27,
            color: AppPalette.whiteColor,
          ),
        ),
        title: Text(
          localeManager.translate('settings'),
          style: AppTextTheme.appBarTitle,
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              localeManager.translate('language'),
              style: AppTextTheme.loraTextTheme.headlineSmall
            ),
            const SizedBox(width: 15),
            DropdownButton<Locale>(
              value: localeManager.currentLocale,
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  localeManager.changeLocale(newLocale);
                }
              },
              items: const [
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
                DropdownMenuItem(value: Locale('tr'), child: Text('Türkçe')),
              ],
              dropdownColor: AppPalette.secondaryBackgroundColor,
             ),
          ],
        ),
      ),
    );
  }
}
