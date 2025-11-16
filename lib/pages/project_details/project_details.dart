import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../core/models/project.dart';
import '../../../core/services/helper.dart';
import '../../../core/theme/style.dart';
import '../../../core/widgets/share_or_copy_button.dart';
import '../../core/mixins/url_launcher.dart';

class ProjectDetails extends ConsumerWidget with UrlLauncherMixin {
  const ProjectDetails({super.key, this.project, this.selectedColor});
  static const routeName = '/details';
  final Project? project;
  final int? selectedColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final color = Color(selectedColor ?? primaryColor.toARGB32());

    // Handle null project
    if (project == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Project Details')),
        body: const Center(child: Text('No project data available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          project?.title ?? 'Project Details',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isMobile)
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: project?.image == null || project!.image!.isEmpty
                        ? Icon(
                            FontAwesomeIcons.image,
                            size: 80,
                            color: Color(
                              selectedColor ?? primaryColor.toARGB32(),
                            ),
                          )
                        : Image.network(
                            project?.image ?? '',
                            fit: BoxFit.contain,
                          ),
                  ),
                )
              else
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            project?.image ?? '',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Description',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              project?.description ?? '',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.copyWith(height: 1.6),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Technologies',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: project?.technologies?.map((entry) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: color.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: color.withValues(alpha: 0.8),
                                          width: 1,
                                        ),
                                      ),
                                      child: Text(
                                        entry,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: color.withValues(
                                                alpha: 0.8,
                                              ),
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    );
                                  }).toList() ??
                                  [],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              if (isMobile) ...[
                const SizedBox(height: 24),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  project?.description ?? '',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(height: 1.6),
                ),
                const SizedBox(height: 24),
                Text(
                  'Technologies',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project?.technologies?.map((entry) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: color.withValues(alpha: 0.8),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            entry,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: color.withValues(alpha: 0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        );
                      }).toList() ??
                      [],
                ),
              ],
              if (project?.images?.isNotEmpty ?? false) ...[
                const SizedBox(height: 24),
                Text(
                  'Screenshots',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 420,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: project?.images?.length ?? 0,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: project?.hasGradient == true
                              ? generatedGrideant()
                              : null,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: project?.hasGradient == false
                            ? null
                            : const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 24,
                              ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            project?.images?[index] ?? '',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              if ((project?.appStoreUrl != null &&
                      project!.appStoreUrl!.isNotEmpty) ||
                  (project?.googlePlayUrl != null &&
                      project!.googlePlayUrl!.isNotEmpty) ||
                  (project?.githubUrl != null &&
                      project!.githubUrl!.isNotEmpty))
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Row(
                    spacing: 12,
                    children: [
                      if (project?.appStoreUrl != null &&
                          project!.appStoreUrl!.isNotEmpty)
                        OpenOrCopyButton(
                          label: 'App Store Url',
                          icon: FontAwesomeIcons.appStore,
                          color: selectedColor ?? 0,
                          url: project?.appStoreUrl ?? '',
                        ),
                      if (project?.googlePlayUrl != null &&
                          project!.googlePlayUrl!.isNotEmpty)
                        OpenOrCopyButton(
                          label: 'Google Play Url',
                          icon: FontAwesomeIcons.googlePlay,
                          color: selectedColor ?? 0,
                          url: project?.googlePlayUrl ?? '',
                        ),
                      if (project?.githubUrl != null &&
                          project!.githubUrl!.isNotEmpty)
                        OpenOrCopyButton(
                          label: 'GitHub Url',
                          icon: FontAwesomeIcons.github,
                          color: selectedColor ?? 0,
                          url: project?.githubUrl ?? '',
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
