import 'package:flutter/material.dart';
import 'package:link_directory/widgets/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDevPage extends StatelessWidget {
  const AboutDevPage({super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Konnte $url nicht öffnen');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "Über den Entwickler"),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(
              'assets/dev_avatar.png',
            ), // Dein Profilbild
          ),
          const SizedBox(height: 20),
          Text(
            "Eaven Schmalz",
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontFamily: "SpaceGrotesk",
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Flutter Developer • App Enthusiast",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontFamily: "SpaceGrotesk",
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Hi, ich bin Eaven! Ich entwickle mit Liebe minimalistische und durchdachte Flutter-Apps. "
            "Diese App ist ein kleines Herzensprojekt von mir – danke, dass du sie verwendest!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "SpaceGrotesk",
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Divider(color: Colors.grey[400]),
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text(
              "Website",
              style: TextStyle(
                fontFamily: "SpaceGrotesk",
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap:
                () => _launchURL(
                  "https://eavencs.github.io/PortfolioCV.Frontend/pages/index.html",
                ),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text(
              "E-Mail",
              style: TextStyle(
                fontFamily: "SpaceGrotesk",
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => _launchURL("mailto:Schmalze6@gmail.com"),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text(
              "GitHub",
              style: TextStyle(
                fontFamily: "SpaceGrotesk",
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => _launchURL("https://github.com/EavenCS"),
          ),
        ],
      ),
    );
  }
}
