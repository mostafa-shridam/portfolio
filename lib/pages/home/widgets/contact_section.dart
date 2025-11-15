import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../core/mixins/copy.dart';
import '../../../core/mixins/scaffold_messeneger.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/share_or_copy_button.dart';


class ContactSection extends StatelessWidget
    with CopyMixin, ScaffoldMessengerMixin {
  const ContactSection({
    super.key,
    required this.userData,
    required this.selectedColor,
  });
  final UserModel userData;
  final int selectedColor;
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final currentColor = Color(selectedColor);
    return Container(
      color: currentColor.withValues(alpha: 0.1),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 16 : 32,
      ),
      margin: EdgeInsets.only(top: isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Contact Me',
            style: Theme.of(context).textTheme.titleLarge,
          ).animate().fadeIn().slideX(begin: -0.2, end: 0),
          const SizedBox(height: 8),
          Text(
            'I\'m always open to new opportunities and collaborations. Feel free to reach out to me.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'My phone number: ${userData.phone ?? ''}',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              IconButton(
                onPressed: () {
                  copyToClipboard(userData.phone ?? '');
                  showSnackBar(
                    context: context,
                    message: 'Phone number copied to clipboard',
                    color: selectedColor,
                  );
                },
                icon: Icon(Icons.copy, size: 16, color: currentColor),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 24 : 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: isMobile ? 8 : 16,
            children: [
              if (userData.email?.isNotEmpty ?? false || userData.email != null)
                OpenOrCopyButton(
                  label: 'Email',
                  icon: Icons.email,
                  url: 'mailto:${userData.email ?? ''}',
                  color: selectedColor,
                ),
              if (userData.socialLinks?.linkedinUrl?.isNotEmpty ??
                  false || userData.socialLinks?.linkedinUrl != null)
                OpenOrCopyButton(
                  label: 'LinkedIn',
                  icon: FontAwesomeIcons.linkedin,
                  url: userData.profileImage ?? '',
                  color: selectedColor,
                ),
              if (userData.phone?.isNotEmpty ?? false || userData.phone != null)
                OpenOrCopyButton(
                  label: 'WhatsApp',
                  icon: FontAwesomeIcons.whatsapp,
                  url: 'https://wa.me/${userData.phone ?? ''}',
                  color: selectedColor,
                ),
              if (userData.socialLinks?.facebookUrl?.isNotEmpty ??
                  false || userData.socialLinks?.facebookUrl != null)
                OpenOrCopyButton(
                  label: 'Facebook',
                  icon: FontAwesomeIcons.facebook,
                  url: userData.socialLinks?.facebookUrl ?? '',
                  color: selectedColor,
                ),
              if (userData.socialLinks?.instagramUrl?.isNotEmpty ??
                  false || userData.socialLinks?.instagramUrl != null)
                OpenOrCopyButton(
                  label: 'Instagram',
                  icon: FontAwesomeIcons.instagram,
                  url: userData.socialLinks?.instagramUrl ?? '',
                  color: selectedColor,
                ),
              if (userData.socialLinks?.behanceUrl?.isNotEmpty ??
                  false || userData.socialLinks?.behanceUrl != null)
                OpenOrCopyButton(
                  label: 'Behance',
                  icon: FontAwesomeIcons.behance,
                  url: userData.socialLinks?.behanceUrl ?? '',
                  color: selectedColor,
                ),
              if (userData.socialLinks?.dribbbleUrl?.isNotEmpty ??
                  false || userData.socialLinks?.dribbbleUrl != null)
                OpenOrCopyButton(
                  label: 'Dribbble',
                  icon: FontAwesomeIcons.dribbble,
                  url: userData.socialLinks?.dribbbleUrl ?? '',
                  color: selectedColor,
                ),
            ],
          ),
          // const SizedBox(height: 16),
          // OpenOrCopyButton(
          //   label: 'Now, you can share your portfolio',
          //   icon: FontAwesomeIcons.share,
          //   share:
          //       'https://mostafa-shridam.github.io/portfolio/${userData.id ?? ''}',
          //   color: selectedColor,
          //   width: 340,
          // ),
        ],
      ),
    );
  }
}
