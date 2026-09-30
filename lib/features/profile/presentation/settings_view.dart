import 'package:flutter/material.dart';
import '../../../core/storage/language_storage.dart';
import '../../../core/widgets/curved_page.dart';
import 'widgets/language_button.dart';

/// Language: AR / EN (saved on the device, applied at once).
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedPage(
      title: 'Settings',
      body: ValueListenableBuilder<Locale>(
        valueListenable: LanguageStorage.localeNotifier,
        builder: (context, locale, _) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Language',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      LanguageButton(
                        label: 'AR',
                        isSelected: locale.languageCode == 'ar',
                        onTap: () => LanguageStorage.change('ar'),
                      ),
                      const SizedBox(width: 8),
                      LanguageButton(
                        label: 'EN',
                        isSelected: locale.languageCode == 'en',
                        onTap: () => LanguageStorage.change('en'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
