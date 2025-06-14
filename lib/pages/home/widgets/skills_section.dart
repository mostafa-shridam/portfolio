import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../core/assets.dart';
import '../../../core/theme.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Container(
      color: isDarkMode ? graySwatch.shade800 : graySwatch.shade200,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 16 : 32,
      ),
      child: Column(
        children: [
          Text(
            'Skills',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'The skills, tools, and technologies I\'m really good at :',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            children: [
              _TechChip(label: 'Flutter', image: Assets.assetsSvgFlutter),
              _TechChip(label: 'Dart', image: Assets.assetsSvgDart),
              _TechChip(label: 'Firebase', image: Assets.assetsSvgFirebase),
              _TechChip(label: 'Git', image: Assets.assetsSvgGit),
              _TechChip(label: 'GitHub', image: Assets.assetsSvgGithub),
              _TechChip(label: 'Android', image: Assets.assetsSvgAndroid),
              _TechChip(label: 'IOS', image: Assets.assetsSvgIOS),
              _TechChip(
                  label: 'Restful Api', image: Assets.assetsSvgRestfulApi),
              _TechChip(
                label: 'Supabase',
                image: Assets.assetsSvgSupabase,
                color: true,
              ),
              _TechChip(label: 'Postman', image: Assets.assetsSvgPostman),
              _TechChip(label: 'Onesignal', image: Assets.assetsSvgOnesignal),
              _TechChip(label: 'Figma', image: Assets.assetsSvgFigma),
            ],
          ),
        ],
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;
  final String image;
  final bool color;

  const _TechChip({
    this.color = false,
    required this.label,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          image,
          width: 54,
          height: 54,
          colorFilter: color
              ? ColorFilter.mode(
                  Colors.green,
                  BlendMode.srcIn,
                )
              : null,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
