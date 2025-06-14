import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AboutSection extends ConsumerWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 16 : 32,
      ),
      child: isMobile
          ? _buildMobileLayout(context, theme)
          : _buildDesktopLayout(context, theme),
    );
  }

  Widget _buildMobileLayout(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'About Me'),
        const SizedBox(height: 16),
        Text(
          'I am a passionate Flutter developer with experience in building beautiful and performant mobile applications. I love creating intuitive user interfaces and solving complex problems through clean and efficient code.',
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.6,
          ),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 32),
        _buildSectionTitle(context, 'Work Experience'),
        const SizedBox(height: 16),
        _buildWorkExperienceItem(
          context,
          'Flutter Developer',
          'Super App',
          '2025 - Present',
          [
            'Developed and maintained multiple Flutter applications',
            'Implemented clean architecture and state management using Riverpod',
            'Collaborated with UI/UX designers to create beautiful interfaces',
            'Integrated various APIs and third-party services',
          ],
          theme,
        ),
        const SizedBox(height: 32),
        _buildSectionTitle(context, 'Education'),
        const SizedBox(height: 16),
        _buildEducationItem(
          context,
          'Bachelor of Management Information Systems',
          'Obour Institutes',
          '2021 - 2025',
        ),
        const SizedBox(height: 16),
        _buildEducationItem(
          context,
          'The Complete 2022 Flutter & Dart Development Course [Arabic]',
          'Udemy',
          '2023',
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, ThemeData theme) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(context, 'About Me'),
              const SizedBox(height: 16),
              Text(
                'I am a passionate Flutter developer with experience in building beautiful and performant mobile applications. I love creating intuitive user interfaces and solving complex problems through clean and efficient code.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                ),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 32),
              _buildSectionTitle(context, 'Work Experience'),
              const SizedBox(height: 16),
              _buildWorkExperienceItem(
                context,
                'Flutter Developer',
                'Super App',
                '2025 - Present',
                [
                  'Developed and maintained multiple Flutter applications',
                  'Implemented clean architecture and state management using Riverpod',
                  'Collaborated with UI/UX designers to create beautiful interfaces',
                  'Integrated various APIs and third-party services',
                ],
                theme,
              ),
            ],
          ),
        ),
        SizedBox(
          width: isMobile ? 24 : 32,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(context, 'Education'),
              const SizedBox(height: 16),
              _buildEducationItem(
                context,
                'Bachelor of Management Information Systems',
                'Obour Institutes',
                '2021 - 2025',
              ),
              const SizedBox(height: 16),
              _buildEducationItem(
                context,
                'The Complete 2022 Flutter & Dart Development Course [Arabic]',
                'Udemy',
                '2023',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineLarge,
    ).animate().fadeIn().slideX(begin: -0.2, end: 0);
  }

  Widget _buildWorkExperienceItem(
    BuildContext context,
    String title,
    String company,
    String period,
    List<String> responsibilities,
    ThemeData theme,
  ) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Container(
      padding: EdgeInsets.all(
        isMobile ? 12 : 16,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withAlpha(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            company,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            period,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          ...responsibilities.map((responsibility) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.circle,
                      size: isMobile ? 6 : 8,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        responsibility,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          height: 1.5,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildEducationItem(
    BuildContext context,
    String title,
    String subtitle,
    String year,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        Text(
          year,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[500],
              ),
        ),
      ],
    );
  }
}
