import 'package:flutter/material.dart';

import '../theme/style.dart';

class MyChip extends StatelessWidget {
  const MyChip({
    super.key,
    required this.title,
    this.selectedColor,
    this.onDeleted,
    this.icon,
    this.border,
  });
  final String title;
  final int? selectedColor;
  final VoidCallback? onDeleted;
  final IconData? icon;
  final double? border;
  @override
  Widget build(BuildContext context) {
    return Chip(
      onDeleted: onDeleted,
      padding: const EdgeInsets.all(6),
      avatar: icon == null
          ? null
          : Icon(
              icon,
              color: Color(selectedColor ?? primaryColor.toARGB32()),
            ),
      label: Text(title, style: Theme.of(context).textTheme.bodySmall),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(border ?? 8)),
      side: BorderSide(color: Color(selectedColor ?? primaryColor.toARGB32())),
      backgroundColor: Color(
        selectedColor ?? primaryColor.toARGB32(),
      ).withValues(alpha: 0.3),
    );
  }
}
