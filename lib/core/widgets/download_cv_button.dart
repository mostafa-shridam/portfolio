import 'package:flutter/material.dart';
import '../mixins/scaffold_messeneger.dart';
import '../mixins/url_launcher.dart';

class DownloadCvButton extends StatelessWidget
    with UrlLauncherMixin, ScaffoldMessengerMixin {
  const DownloadCvButton({
    super.key,
    required this.currentColor,
    required this.url,
  });
  final Color currentColor;
  final String url;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => url.isNotEmpty
          ? myLaunchUrl(url)
          : {
              showSnackBar(
                context: context,
                message: 'No CV available',
                color: currentColor.toARGB32(),
              ),
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(top: 12, bottom: 8),
        decoration: BoxDecoration(
          color: currentColor.withAlpha(60),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Download CV',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Icon(Icons.download, color: currentColor),
          ],
        ),
      ),
    );
  }
}
