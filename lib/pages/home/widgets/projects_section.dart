import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../constants.dart';
import '../../../core/theme.dart';
import '../../project_details/project_details.dart';
import '../models/projects.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 16 : 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Projects',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ).animate().fadeIn().slideX(begin: -0.2, end: 0),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount: isMobile ? 1 : isTablet ? 1 : 3,
              childAspectRatio: isMobile ? 2 : isTablet ? 3 : 2,
            ),
            itemBuilder: (context, index) =>
                ProjectCard(project: projects[index], index: index),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends ConsumerWidget {
  final Project project;
  final int index;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: isDarkMode ? graySwatch.shade600 : graySwatch.shade200,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            ProjectDetails.routeName,
            arguments: project,
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? graySwatch.shade800 : graySwatch.shade300,
              ),
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Image.asset(
                  project.image,
                  fit: BoxFit.contain,
                  width: isMobile ? 100 : 120,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(
                  isMobile ? 8 : 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      project.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                      height: isMobile ? 6 : 8,
                    ),
                    Text(
                      project.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Wrap(
                      spacing: isMobile ? 6 : 8,
                      runSpacing: isMobile ? 6 : 8,
                      children: project.tags.entries
                          .map((entry) => ProjectTag(
                                tag: entry.key,
                                color: entry.value,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 100 * index)).slideY(
          begin: 0.2,
          end: 0,
          delay: Duration(milliseconds: 100 * index),
        );
  }
}

class ProjectTag extends StatelessWidget {
  const ProjectTag({
    super.key,
    required this.tag,
    required this.color,
  });
  final String tag;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color,
        ),
        color: color.withAlpha(16),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 4 : 6,
          vertical: isMobile ? 2 : 4,
        ),
        child: Text(
          tag,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: isMobile ? 11 : 12,
              ),
        ),
      ),
    );
  }
}
