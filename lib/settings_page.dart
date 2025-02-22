import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_settings.dart'; // Modeli import et

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appSettings = Provider.of<AppSettings>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sazlamalar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tema üýtgetmek
            ListTile(
              title: const Text('Tema'),
              subtitle: Text(appSettings.isDarkMode
                  ? 'Gara reňk temasy'
                  : 'Açyk reňk temasy'),
              trailing: Switch(
                value: appSettings.isDarkMode,
                onChanged: (value) {
                  appSettings.toggleTheme();
                },
              ),
            ),

            const SizedBox(height: 20),

            // Dil üýtgetmek
            ListTile(
              title: const Text('Dil'),
              subtitle: Text(appSettings.locale.languageCode == 'en'
                  ? 'İňlis dili'
                  : 'Türk dili'),
              trailing: Icon(Icons.language),
              onTap: () {
                appSettings.changeLanguage(
                    appSettings.locale.languageCode == 'en'
                        ? Locale('tr')
                        : Locale('en'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
