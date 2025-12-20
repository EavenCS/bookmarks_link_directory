import 'package:flutter/material.dart';
import 'package:link_directory/pages/about_dev.dart';
import 'package:link_directory/pages/manage_categories.dart';
import 'package:link_directory/widgets/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Einstellungen"),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // 🔹 Kategorienverwaltung
          cardWidget([
            const Text(
              "Kategorien",
              style: TextStyle(
                fontFamily: "SpaceGrotesk",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 8),
            const Text(
              "Bearbeite oder lösche bestehende Kategorien.",
              style: TextStyle(fontFamily: "SpaceGrotesk"),
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
              label: const Text(
                "Kategorien verwalten",
                style: TextStyle(fontFamily: "SpaceGrotesk"),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
            ),
          ]),

          // Über die App
          cardWidget([
            const Text(
              "Über die App",
              style: TextStyle(
                fontFamily: "SpaceGrotesk",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 8),
            const Text(
              "Version: 1.0.0",
              style: TextStyle(fontFamily: "SpaceGrotesk"),
            ),
            const SizedBox(height: 4),
            const Text(
              "Entwickelt von: Eaven-René Schmalz",
              style: TextStyle(fontFamily: "SpaceGrotesk"),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const AboutDevPage()));
              },
              icon: const Icon(Icons.person_outline),
              label: const Text(
                "Über den Entwickler",
                style: TextStyle(fontFamily: "SpaceGrotesk"),
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
