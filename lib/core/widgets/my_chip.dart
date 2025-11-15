import 'package:flutter/material.dart';

import '../theme/style.dart';

class MyChip extends StatelessWidget {
  const MyChip({
    super.key,
    required this.title,
    this.selectedColor,
    this.onDeleted,
  });
  final String title;
  final int? selectedColor;
  final VoidCallback? onDeleted;
  @override
  Widget build(BuildContext context) {
    return Chip(
      onDeleted: onDeleted,
      padding: const EdgeInsets.all(6),
      label: Text(title, style: Theme.of(context).textTheme.bodySmall),
      side: BorderSide(color: Color(selectedColor ?? primaryColor.toARGB32())),
      backgroundColor: Color(
        selectedColor ?? primaryColor.toARGB32(),
      ).withValues(alpha: 0.3),
    );
  }
}
