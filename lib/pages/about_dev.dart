import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/appbar.dart';
import '../l10n/app_localizations.dart';

class AboutDevPage extends StatelessWidget {
  const AboutDevPage({super.key});

  void _launchURL(BuildContext context, String url) async {
    final l10n = AppLocalizations.of(context)!;
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception(l10n.couldNotOpen(url));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: l10n.aboutDeveloperTitle),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(
              'assets/dev_avatar.png',
            ),
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
          Text(
            l10n.aboutDeveloperText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "SpaceGrotesk",
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Divider(color: Colors.grey[400]),
          ListTile(
            leading: const Icon(Icons.link),
            title: Text(
              l10n.website,
              style: const TextStyle(
                fontFamily: "SpaceGrotesk",
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap:
                () => _launchURL(
                  context,
                  "https://eavencs.github.io/PortfolioCV.Frontend/pages/index.html",
                ),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: Text(
              l10n.email,
              style: const TextStyle(
                fontFamily: "SpaceGrotesk",
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => _launchURL(context, "mailto:Schmalze6@gmail.com"),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: Text(
              l10n.github,
              style: const TextStyle(
                fontFamily: "SpaceGrotesk",
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => _launchURL(context, "https://github.com/EavenCS"),
          ),
        ],
      ),
    );
  }
}
