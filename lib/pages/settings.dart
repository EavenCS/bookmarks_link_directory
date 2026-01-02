import 'package:flutter/material.dart';
import 'about_dev.dart';
import 'manage_categories.dart';
import '../widgets/appbar.dart';
import '../l10n/app_localizations.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(title: l10n.settingsTitle),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
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
