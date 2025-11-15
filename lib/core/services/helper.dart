import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

String getLanguageCodeHelper() {
  if (kIsWeb) {
    return 'en';
  }
  final deviceLocale = Platform.localeName.split('_').first;
  for (var loc in supportedLocales) {
    if (deviceLocale == loc.languageCode) {
      return deviceLocale;
    }
  }
  return 'ar';
}

String getMonthName(int month) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return months[month - 1];
}

String formatDateRange(String? startDate, String? endDate, bool isCurrent) {
  if (startDate == null || startDate.isEmpty) {
    return 'Date not specified';
  }

  try {
    final start = DateTime.parse(startDate);
    final startFormatted = '${getMonthName(start.month)} ${start.year}';

    if (isCurrent) {
      return '$startFormatted - Present';
    }

    if (endDate == null || endDate.isEmpty) {
      return startFormatted;
    }

    final end = DateTime.parse(endDate);
    final endFormatted = '${getMonthName(end.month)} ${end.year}';
    return '$startFormatted - $endFormatted';
  } catch (e) {
    // Fallback for invalid date formats
    if (isCurrent) {
      return '$startDate - Present';
    }
    return endDate?.isNotEmpty ?? false ? '$startDate - $endDate' : startDate;
  }
}

// Specialized text field variants
String? defaultEmailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
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

Future<String> selectDate({required BuildContext context}) async {
  String value = '';
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
  );
  if (pickedDate != null) {
    value = pickedDate.toString().split(' ')[0];
    return value;
  }
  return '';
}

List<String> parseListInput(String input) {
  return input
      .split(',')
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toList();
}
