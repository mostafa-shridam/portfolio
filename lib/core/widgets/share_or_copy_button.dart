import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../mixins/copy.dart';
import '../mixins/scaffold_messeneger.dart';
import '../mixins/url_launcher.dart';

class OpenOrCopyButton extends StatelessWidget
    with UrlLauncherMixin, ScaffoldMessengerMixin, CopyMixin {
  final String label;
  final IconData icon;
  final String? url;
  final String? share;
  final double? width;
  final int color;
  const OpenOrCopyButton({
    super.key,
    required this.label,
    required this.icon,
    this.url,
    this.share,
    this.width,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return GestureDetector(
      onTap: () => url?.isNotEmpty ?? false
          ? myLaunchUrl(url ?? '')
          : share?.isNotEmpty ?? false
              ? {
                  copyToClipboard(share ?? ''),
                  showSnackBar(
                    context: context,
                    message: 'Your Portfolio Link Copied to clipboard',
                    color: color,
                  ),
                }
              : showSnackBar(context: context, message: 'No link available'),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Color(color).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 12,
          vertical: isMobile ? 6 : 8,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: isMobile ? 18 : 20, color: Color(color)),
              SizedBox(width: isMobile ? 6 : 8),
              Text(label, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 400.ms);
  }
}
