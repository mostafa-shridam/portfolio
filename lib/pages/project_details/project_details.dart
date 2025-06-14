import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:portfolio/pages/home/models/projects.dart';
import 'package:portfolio/core/theme.dart';

class ProjectDetails extends ConsumerWidget {
  const ProjectDetails({super.key, required this.project});
  final Project project;
  static const routeName = '/project-details';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          project.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isMobile)
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color:
                        isDarkMode ? graySwatch.shade800 : graySwatch.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      project.image,
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
                          color: isDarkMode
                              ? graySwatch.shade800
                              : graySwatch.shade200,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            project.image,
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
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              project.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    height: 1.6,
                                  ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Technologies',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: project.tags.entries.map((entry) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: entry.value.withAlpha(20),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: entry.value,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    entry.key,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: entry.value,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                );
                              }).toList(),
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
                  project.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                      ),
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
                  children: project.tags.entries.map((entry) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: entry.value.withAlpha(20),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: entry.value,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        entry.key,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: entry.value,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    );
                  }).toList(),
                ),
              ],
              if (project.images.isNotEmpty) ...[
                const SizedBox(height: 24),
                Text(
                  'Screenshots',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 420,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: project.images.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: generatedGrideant(),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 32,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            project.images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

LinearGradient generatedGrideant() {
  final Random random = Random();
  final hue = random.nextDouble() * 360;
  final saturation = 0.7 + random.nextDouble() * 0.2; // 70% to 90%
  final brightness = 0.7 + random.nextDouble() * 0.2; // 70% to 90%

  final color1 = HSVColor.fromAHSV(1.0, hue, saturation, brightness).toColor();
  final color2 = HSVColor.fromAHSV(
    1.0,
    (hue + 40) % 360,
    (saturation * 0.95).clamp(0.0, 1.0),
    min(brightness * 1.1, 1.0),
  ).toColor();

  final beginAlignments = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.centerLeft,
  ];

  final endAlignments = [
    Alignment.bottomRight,
    Alignment.bottomCenter,
    Alignment.centerRight,
  ];

  return LinearGradient(
    begin: beginAlignments[random.nextInt(beginAlignments.length)],
    end: endAlignments[random.nextInt(endAlignments.length)],
    colors: [color1, color2],
    stops: const [0.0, 1.0],
    tileMode: TileMode.clamp,
  );
}
