import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../constants.dart';
import '../../../core/theme.dart';
import '../models/courses.dart';

class CoursesSection extends ConsumerWidget {
  const CoursesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Text(
            'Courses & Certifications',
            style: Theme.of(context).textTheme.headlineLarge,
          ).animate().fadeIn().slideX(),
          const SizedBox(height: 30),
          ResponsiveGridView.builder(
            gridDelegate: ResponsiveGridDelegate(
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              minCrossAxisExtent: isMobile ? 200 : 240,
              maxCrossAxisExtent: isMobile ? 250 : 300,
              childAspectRatio: isMobile ? 1.24 : 1.5,
              
            ),
            itemCount: courses.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CourseCard(course: courses[index]);
            },
          )
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    return Card(
      color: isDarkMode ? graySwatch.shade600 : graySwatch.shade200,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => customLaunchUrl(course.url),
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    course.icon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      course.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '${course.platform} - ${course.costractor}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    course.date,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Course> courses = [
  const Course(
    title: 'The Complete 2022 Flutter & Dart Development Course [Arabic]',
    platform: 'Udemy',
    date: '2023',
    icon: FontAwesomeIcons.code,
    url:
        'https://www.udemy.com/course/complete-flutter-arabic/?couponCode=UPGRADE02223',
    costractor: 'Abdullah Mansour',
  ),
  const Course(
    title: 'Complete Flutter & Dart Development Course [Arabic]',
    platform: 'Udemy',
    date: '2024',
    icon: FontAwesomeIcons.code,
    url:
        'https://www.udemy.com/course/best-and-complete-flutter-course-for-beginners/?couponCode=UPGRADE02223',
    costractor: 'Tharwat Samy',
  ),
  const Course(
    title:
        'Dart Programming Language And OOP For Beginner [In Arabic] Flutter & Dart - The Complete Guide',
    platform: 'Udemy',
    date: '2024',
    icon: FontAwesomeIcons.code,
    url:
        'https://www.udemy.com/course/dart-programming-language-and-oop-for-beginner-in-arabic/?couponCode=UPGRADE02223',
    costractor: 'Usama Elgendy',
  ),
  const Course(
    title: 'Flutter REST Movie App: Master Flutter REST API Development',
    platform: 'Udemy',
    date: '2025',
    icon: FontAwesomeIcons.code,
    url:
        'https://www.udemy.com/course/flutter-rest-api-development-course-build-a-movie-app/?couponCode=UPGRADE02223',
    costractor: 'Hussain Mustafa',
  ),
];
