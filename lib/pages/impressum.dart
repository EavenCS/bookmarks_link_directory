import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/appbar.dart';
import '../l10n/app_localizations.dart';

class ImpressumPage extends StatelessWidget {
  const ImpressumPage({super.key});

  void _launchURL(BuildContext context, String url) async {
    final l10n = AppLocalizations.of(context)!;
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.couldNotOpen(url))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(title: l10n.impressumTitle),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            l10n.impressumTitle,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontFamily: "SpaceGrotesk",
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.impressumSubtitle,
            style: TextStyle(
              fontFamily: "SpaceGrotesk",
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          _buildSection(
            context,
            title: l10n.impressumProviderLabel,
            children: [
              "Eaven-René Schmalz",
              "Lamspringer Str. 14",
              "31084 Freden (Leine)",
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            title: l10n.impressumRepresentedBy,
            children: ["Eaven-René Schmalz"],
          ),
          const SizedBox(height: 16),
          _buildSection(
            context,
            title: l10n.impressumContact,
            children: [
              "${l10n.impressumPhone}: +49-176 84042633",
              "E-Mail: schmalze6@gmail.com",
            ],
          ),
          const SizedBox(height: 24),
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            l10n.impressumDisputeResolutionTitle,
            style: const TextStyle(
              fontFamily: "SpaceGrotesk",
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.impressumDisputeResolutionText,
            style: const TextStyle(
              fontFamily: "SpaceGrotesk",
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.impressumPrivacyPolicyTitle,
            style: const TextStyle(
              fontFamily: "SpaceGrotesk",
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => _launchURL(
              context,
              "https://eavencs.github.io/bookmarks_PrivacyPolicy/privacyPolicy.html",
            ),
            child: Text(
              l10n.impressumPrivacyPolicyLink,
              style: const TextStyle(
                fontFamily: "SpaceGrotesk",
                fontSize: 14,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.impressumGeneratedWith,
            style: TextStyle(
              fontFamily: "SpaceGrotesk",
              fontSize: 12,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<String> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: "SpaceGrotesk",
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        ...children.map(
          (text) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: "SpaceGrotesk",
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
