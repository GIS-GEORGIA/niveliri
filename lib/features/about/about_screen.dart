import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/app_localizations.dart';

// Original author's details, kept exactly as in the source app.
const _authorPhone = '593551010';
const _authorPhoneShown = '593 55 10 10';
const _authorFacebook = 'https://www.facebook.com/geomapping2018';

const _developerName = 'გიორგი კაპანაძე / Giorgi Kapanadze · GIS GEORGIA';
const _developerGithub = 'https://github.com/GIS-GEORGIA';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _open(String url) => launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final th = Theme.of(context);
    Widget link(String label, String text, String url) => Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Wrap(children: [
            Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
            InkWell(
              onTap: () => _open(url),
              child: Text(text,
                  style: TextStyle(color: th.colorScheme.primary, fontWeight: FontWeight.bold)),
            ),
          ]),
        );
    return Scaffold(
      appBar: AppBar(title: Text(t.about)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(padding: const EdgeInsets.all(16), children: [
            Text(t.copyright, style: th.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Wrap(children: [
                    Text('${t.originalAuthorTitle}: ',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(t.originalAuthorName),
                  ]),
                  link(t.phone, _authorPhoneShown, 'tel:$_authorPhone'),
                  link(t.facebook, 'facebook.com/geomapping2018', _authorFacebook),
                  const SizedBox(height: 8),
                  Text(t.feedbackNote, style: th.textTheme.bodySmall),
                ]),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Wrap(children: [
                    Text('${t.developerTitle}: ',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Text(_developerName),
                  ]),
                  link('GitHub', 'github.com/GIS-GEORGIA', _developerGithub),
                  const SizedBox(height: 8),
                  Text(t.usedWithPermission, style: th.textTheme.bodySmall),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
