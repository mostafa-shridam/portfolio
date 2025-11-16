import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../core/models/project.dart';
import '../../../core/widgets/my_chip.dart';
import '../../../providers/projects.dart';
import '../../project_details/project_details.dart';

class ProjectsSection extends ConsumerStatefulWidget {
  const ProjectsSection({super.key, required this.selectedColor});
  final int selectedColor;
  // final List<Project> projects;

  @override
  ConsumerState<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends ConsumerState<ProjectsSection> {
  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final projects = ref.watch(
      projectsProvider.select((value) => value.projects ?? []),
    );
    final isLoading = ref.watch(
      projectsProvider.select((value) => value.isLoading ?? false),
    );

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: isMobile ? 16 : 32,
      ),
      child: Column(
        crossAxisAlignment: projects.isNotEmpty
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Projects',
                style: Theme.of(context).textTheme.titleLarge,
              ).animate().fadeIn().slideX(begin: -0.2, end: 0),
            ],
          ),
          const SizedBox(height: 16),
          if (projects.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'No projects added yet.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: projects.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                crossAxisCount: isMobile
                    ? 1
                    : isTablet
                        ? 2
                        : 3,
                childAspectRatio: isMobile
                    ? 2.1
                    : isTablet
                        ? 1.8
                        : 2.4,
              ),
              itemBuilder: (context, index) => ProjectCard(
                project: projects[index],
                index: index,
                selectedColor: widget.selectedColor,
              ),
            ),
        ],
      ),
    );
  }
}

class ProjectCard extends ConsumerWidget {
  final Project project;
  final int index;
  final int selectedColor;
  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Color(selectedColor).withValues(alpha: 0.4),
          width: 2,
        ),
      ),
      color: Color(selectedColor).withValues(alpha: 0.2),
      child: InkWell(
        onTap: () {
          context.goNamed(
            ProjectDetails.routeName,
            extra: {'project': project, 'selectedColor': selectedColor},
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(selectedColor).withValues(alpha: 0.3),
              ),
              height: MediaQuery.of(context).size.height,
              width: 170,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: project.image?.isEmpty ?? true
                      ? Icon(
                          FontAwesomeIcons.image,
                          size: 100,
                          color: Color(selectedColor),
                        )
                      : Image.network(
                          project.image ?? '',
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 8 : 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      project.title ?? '',
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: isMobile ? 6 : 8),
                    Text(
                      project.description ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 16),
                    if (project.technologies?.isNotEmpty ?? false)
                      Wrap(
                        spacing: isMobile ? 6 : 8,
                        runSpacing: isMobile ? 6 : 8,
                        children: project.technologies!
                            .take(6)
                            .map(
                              (entry) => MyChip(
                                title: entry,
                                selectedColor: selectedColor,
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 100 * index))
        .slideY(begin: 0.2, end: 0, delay: Duration(milliseconds: 100 * index));
  }
}
