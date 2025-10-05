import 'package:flutter/material.dart';
import 'package:link_directory/pages/about_dev.dart';
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
      appBar: AppBar(
        title: const Text(
          "Einstellungen",
          style: TextStyle(
            fontFamily: "SpaceGrotesk",
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          cardWidget([
            const Text(
              "Support",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(color: Colors.grey[400]),

            const SizedBox(height: 12),
            const Text(
              "Wenn du Fragen oder Probleme hast, kontaktiere uns gern per E-Mail.",
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _sendSupportEmail,
              icon: const Icon(Icons.mail_outline),
              label: const Text("Support kontaktieren"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
            ),
          ]),
          cardWidget([
            const Text(
              "Über die App",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 12),
            const Text("Version: 1.0.0"),
            const SizedBox(height: 4),
            const Text("Entwickelt von: Eaven-René Schmalz"),
            const SizedBox(height: 8),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const AboutDevPage()),
                );
              },
              icon: const Icon(Icons.person),
              label: const Text("Über den Entwickler"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
            ),
          ]),
          cardWidget([
            const Text(
              "Support",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(color: Colors.grey[400]),

            const SizedBox(height: 12),
            const Text(
              "Wenn du Fragen oder Probleme hast, kontaktiere uns gern per E-Mail.",
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _sendSupportEmail,
              icon: const Icon(Icons.mail_outline),
              label: const Text("Support kontaktieren"),
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

  void _sendSupportEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'schmalze6@gmail.com',
      query: Uri.encodeFull('subject=Supportanfrage zur App'),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      _showError("E-Mail-App konnte nicht geöffnet werden.");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

// Wiederverwendbare Card-Funktion
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
