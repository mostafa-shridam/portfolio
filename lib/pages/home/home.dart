import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../core/theme.dart';
import '../../providers/app_provider.dart';
import 'widgets/about_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/courses_section.dart';
import 'widgets/hero_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/nav_item.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    return Scaffold(
      drawer: isMobile
          ? Drawer(
              child: ListView(
                children: [
                  const NavItemMobile(index: 0, title: 'Home'),
                  const NavItemMobile(index: 1, title: 'About'),
                  const NavItemMobile(index: 2, title: 'Skills'),
                  const NavItemMobile(index: 3, title: 'Projects'),
                  const NavItemMobile(index: 4, title: 'Courses'),
                  const NavItemMobile(index: 5, title: 'Contact'),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    margin: const EdgeInsets.only(bottom: 16),
                    width: double.infinity,
                    color:
                        isDarkMode ? graySwatch.shade800 : graySwatch.shade200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Theme mode',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                              isDarkMode ? Icons.light_mode : Icons.dark_mode),
                          onPressed: () {
                            ref.read(appProvider.notifier).toggleTheme();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : null,
      appBar: AppBar(
        
        leading: isMobile
            ? null
            : IconButton(
                icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
                onPressed: () {
                  ref.read(appProvider.notifier).toggleTheme();
                },
              ),
        actions: isMobile
            ? null
            : [
                NavItem(index: 0, title: 'Home'),
                NavItem(index: 1, title: 'About'),
                NavItem(index: 2, title: 'Skills'),
                NavItem(index: 3, title: 'Projects'),
                NavItem(index: 4, title: 'Courses'),
                NavItem(index: 5, title: 'Contact'),
                const SizedBox(width: 16),
              ],
        title: Text(
          'Mostafa Portfolio',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: PrimaryScrollController(
        controller: ref.watch(appProvider).scrollController,
        child: SingleChildScrollView(
          controller: ref.watch(appProvider).scrollController,
          child: Column(
            children: [
              const HeroSection(),
              const AboutSection(),
              const SkillsSection(),
              const ProjectsSection(),
              const CoursesSection(),
              const ContactSection(),
            ],
          ),
        ),
      ),
    );
  }
}
