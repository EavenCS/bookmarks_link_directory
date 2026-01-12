import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'about_dev.dart';
import 'manage_categories.dart';
import 'impressum.dart';
import '../widgets/appbar.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: l10n.settingsTitle),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          cardWidget([
            Text(
              l10n.appearance,
              style: const TextStyle(
                fontFamily: "SpaceGrotesk",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                l10n.darkMode,
                style: const TextStyle(fontFamily: "SpaceGrotesk"),
              ),
              subtitle: Text(
                l10n.darkModeDescription,
                style: const TextStyle(
                  fontFamily: "SpaceGrotesk",
                  fontSize: 12,
                ),
              ),
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ]),

          cardWidget([
            Text(
              l10n.categories,
              style: const TextStyle(
                fontFamily: "SpaceGrotesk",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text(
              l10n.editOrDeleteCategories,
              style: const TextStyle(fontFamily: "SpaceGrotesk"),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ManageCategoriesPage(),
                  ),
                );
              },
              icon: const Icon(Icons.category),
              label: Text(
                l10n.manageCategories,
                style: const TextStyle(fontFamily: "SpaceGrotesk"),
              ),
              style: ElevatedButton.styleFrom(),
            ),
          ]),

          cardWidget([
            Text(
              l10n.aboutApp,
              style: const TextStyle(
                fontFamily: "SpaceGrotesk",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text(
              l10n.version,
              style: const TextStyle(fontFamily: "SpaceGrotesk"),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.developedBy,
              style: const TextStyle(fontFamily: "SpaceGrotesk"),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const AboutDevPage()));
              },
              icon: const Icon(Icons.person_outline),
              label: Text(
                l10n.aboutDeveloper,
                style: const TextStyle(fontFamily: "SpaceGrotesk"),
              ),
              style: ElevatedButton.styleFrom(),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ImpressumPage()),
                );
              },
              icon: const Icon(Icons.info_outline),
              label: Text(
                l10n.impressumTitle,
                style: const TextStyle(fontFamily: "SpaceGrotesk"),
              ),
              style: ElevatedButton.styleFrom(),
            ),
          ]),
        ],
      ),
    );
  }
}

Widget cardWidget(List<Widget> children) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    ),
  );
}
