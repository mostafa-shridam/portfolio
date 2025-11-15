import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../core/mixins/url_launcher.dart';
import '../../../core/models/course.dart';
import '../../../providers/courses.dart';

class CoursesSection extends ConsumerWidget with UrlLauncherMixin {
  const CoursesSection({super.key, required this.selectedColor});
  final int selectedColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final textTheme = Theme.of(context).textTheme;

    final courses = ref.watch(coursesProvider.select((e) => e.courses ?? []));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: courses.isNotEmpty
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Courses & Certifications',
                style: textTheme.titleLarge,
              ).animate().fadeIn().slideX(),
            ],
          ),
          const SizedBox(height: 16),
          if (courses.isEmpty)
            Text(
              'No courses or certifications available at the moment.',
              style: textTheme.bodyMedium,
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: courses.map((course) {
                return CourseCard(
                  course: courses[courses.indexOf(course)],
                  selectedColor: selectedColor,
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget with UrlLauncherMixin {
  final Course course;

  const CourseCard({
    super.key,
    required this.course,
    required this.selectedColor,
  });
  final int selectedColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 360,
      child: Card(
        color: Color(selectedColor).withValues(alpha: 0.1),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: Color(selectedColor).withValues(alpha: 0.4),
            width: 2,
          ),
        ),
        child: InkWell(
          onTap: () => myLaunchUrl(course.certificateUrl ?? ''),
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      FontAwesomeIcons.code,
                      color: Color(selectedColor),
                      size: 24,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        course.title ?? '',
                        style: textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  '${course.platform} - ${course.instructor}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Color(selectedColor)),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      course.completedDate ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Color(selectedColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
