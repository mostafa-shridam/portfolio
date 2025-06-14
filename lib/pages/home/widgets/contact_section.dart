import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:portfolio/core/theme.dart';

import '../../../constants.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isDarkMode = Theme.of(context).colorScheme.brightness == Brightness.dark;
    return Container(
      color: isDarkMode ? graySwatch.shade800 : graySwatch.shade200,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 16 : 32,
      ),
      margin: EdgeInsets.only(
        top: isMobile ? 16 : 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Contact Me',
            style: Theme.of(context).textTheme.headlineLarge,
          ).animate().fadeIn().slideX(begin: -0.2, end: 0),
          SizedBox(
            height: isMobile ? 24 : 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: isMobile ? 12 : 16,
            children: [
              const ContactButton(
                label: 'Email',
                icon: Icons.email,
                url: 'mailto:$myEmail',
              ).animate().fadeIn(delay: 200.ms),
                const ContactButton(
                  label: 'LinkedIn',
                  icon: FontAwesomeIcons.linkedin,
                  url: myLinkedin,
                ).animate().fadeIn(delay: 400.ms),
                    const ContactButton(
                label: 'WhatsApp',
                icon: FontAwesomeIcons.whatsapp,
                url: 'https://wa.me/$myPhone',
              ).animate().fadeIn(delay: 400.ms),
              const ContactButton(
                label: 'Facebook',
                icon: FontAwesomeIcons.facebook,
                url: myFacebook,
              ).animate().fadeIn(delay: 400.ms),
            ],
          ),
        ],
      ),
    );
  }
}

class ContactButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String url;

  const ContactButton({
    super.key,
    required this.label,
    required this.icon,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => customLaunchUrl(url),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? graySwatch.shade600 : graySwatch.shade300,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 12,
          vertical: isMobile ? 6 : 8,
        ),
        child: Center(
          child: Row(
            children: [
              Icon(
                icon,
                size: isMobile ? 18 : 20,
              ),
              SizedBox(
                width: isMobile ? 6 : 8,
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color:
                          isDarkMode ? graySwatch.shade50 : graySwatch.shade900,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
