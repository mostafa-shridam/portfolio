import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/core/mixins/url_launcher.dart';
import 'package:portfolio/providers/init.dart';
import 'package:portfolio/providers/user.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../core/extensions/theme_mode.dart';
import '../../core/models/user_model.dart';
import '../../core/portfolio_templates/developer_professional/widgets/download_cv_button.dart';
import '../../core/theme/style.dart';
import '../../providers/settings.dart';
import 'widgets/about_section.dart';
import 'widgets/contact_section.dart';
import 'widgets/courses_section.dart';
import 'widgets/hero_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/nav_item.dart';

class HomePage extends ConsumerStatefulWidget {
  static const routeName = '/home';
  final String userId;
  const HomePage({super.key, required this.userId});
  @override
  ConsumerState<HomePage> createState() => _ProfessionalDevState();
}

class _ProfessionalDevState extends ConsumerState<HomePage>
    with UrlLauncherMixin {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () async =>
          await ref.read(initProvider.notifier).initAllData(widget.userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;

    final userData = ref.read(
      userDataProvider.select((e) => e.user),
    );
    final selectedColor = ref.read(
      userDataProvider.select(
        (e) => e.user?.selectedColor ?? primaryColor.toARGB32(),
      ),
    );
    final isLoading = ref.watch(
      userDataProvider.select((e) => e.isLoading),
    );
    final isError = ref.watch(
      initProvider.select((e) => e.isError),
    );
    final errMessage = ref.watch(initProvider.select((e) => e.errorMessage));
    final currentColor = Color(selectedColor);
    if (isLoading == true) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (userData == null || isError == true) {
      return Scaffold(
        body: Center(
          child:
              Text(isError == true ? '$errMessage' : 'No user data available'),
        ),
      );
    }
    return Scaffold(
      backgroundColor: currentColor.withValues(alpha: 0.1),
      drawer: isMobile
          ? Drawer(
              backgroundColor: currentColor,
              surfaceTintColor: currentColor,
              child: ListView(
                children: [
                  NavItemMobile(
                    index: 0,
                    title: 'Home',
                    selectedColor: selectedColor,
                  ),
                  NavItemMobile(
                    index: 1,
                    title: 'About',
                    selectedColor: selectedColor,
                  ),
                  NavItemMobile(
                    index: 2,
                    title: 'Skills',
                    selectedColor: selectedColor,
                  ),
                  NavItemMobile(
                    index: 3,
                    title: 'Projects',
                    selectedColor: selectedColor,
                  ),
                  NavItemMobile(
                    index: 4,
                    title: 'Courses',
                    selectedColor: selectedColor,
                  ),
                  NavItemMobile(
                    index: 5,
                    title: 'Contact',
                    selectedColor: selectedColor,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    width: double.infinity,
                    color: currentColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Theme mode',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: Icon(
                            isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          ),
                          onPressed: () {
                            ref.read(settingsProvider.notifier).changeThemeMode(
                                  isDarkMode ? Thememode.light : Thememode.dark,
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  GestureDetector(
                    onTap: () => myLaunchUrl(userData.resumeUrl ?? ''),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Color(selectedColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Download CV',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Icon(Icons.download),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
      appBar: AppBar(
        backgroundColor: currentColor.withValues(alpha: 0.3),
        actionsPadding: EdgeInsets.zero,
        actions: isMobile
            ? null
            : [
                IconButton(
                  icon: Icon(
                    isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: currentColor,
                  ),
                  onPressed: () {
                    ref.read(settingsProvider.notifier).changeThemeMode(
                          isDarkMode ? Thememode.light : Thememode.dark,
                        );
                  },
                ),
                const SizedBox(width: 16),
                NavItem(index: 0, title: 'Home'),
                NavItem(index: 1.2, title: 'About'),
                NavItem(index: 2.15, title: 'Skills'),
                NavItem(index: 2.54, title: 'Projects'),
                NavItem(index: 3.04, title: 'Courses'),
                NavItem(index: 5, title: 'Contact'),
                const SizedBox(width: 16),
                DownloadCvButton(
                  currentColor: currentColor,
                  url: userData.resumeUrl ?? '',
                ),
                const SizedBox(width: 16),
              ],
        title: Text(
          '${userData.name ?? ''} Portfolio',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        controller: ref.watch(settingsProvider.notifier).scrollController,
        child: Column(
          children: [
            HeroSection(userData: userData, selectedColor: selectedColor),
            AboutSection(selectedColor: selectedColor),
            SkillsSection(selectedColor: selectedColor),
            ProjectsSection(selectedColor: selectedColor),
            CoursesSection(selectedColor: selectedColor),
            ContactSection(userData: userData, selectedColor: selectedColor),
          ],
        ),
      ),
    );
  }
}
