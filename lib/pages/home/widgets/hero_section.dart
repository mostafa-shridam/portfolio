import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/constants.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../core/assets.dart';

class HeroSection extends ConsumerWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 32,
                  vertical: isMobile ? 16 : 32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: isMobile ? 80 : 120,
                      backgroundImage: const AssetImage(Assets.assetsProfile),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Hello, I\'m',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                    Text(
                      myName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: isMobile ? 36 : 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    )
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .slideX(begin: -0.2, end: 0, duration: 600.ms),
                    const SizedBox(height: 16),
                    Text(
                      'Flutter Developer',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white70,
                          ),
                    )
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 600.ms)
                        .slideX(begin: -0.2, end: 0, duration: 600.ms),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 6,
                      children: [
                        _buildSocialButton(
                          icon: FontAwesomeIcons.github,
                          url: myGithub,
                        ),
                        _buildSocialButton(
                          icon: FontAwesomeIcons.linkedin,
                          url: myLinkedin,
                        ),
                        _buildSocialButton(
                          icon: Icons.email,
                          url: 'mailto:$myEmail',
                        ),
                        _buildSocialButton(
                          icon: FontAwesomeIcons.whatsapp,
                          url: 'https://wa.me/$myPhone',
                        ),
                        _buildSocialButton(
                          icon: FontAwesomeIcons.facebook,
                          url: myFacebook,
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 600.ms)
                        .slideX(begin: -0.2, end: 0, duration: 600.ms),
                  ],
                ),
              ),
            ),
            if (!isMobile)
              Expanded(
                child: Center(
                  child: Icon(
                    Icons.code,
                    size: isMobile ? 150 : 200,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({required IconData icon, required String url}) {
    return IconButton(
      icon: FaIcon(icon),
      color: Colors.white,
      iconSize: 28,
      onPressed: () => customLaunchUrl(url),
    );
  }
}
