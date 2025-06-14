import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../../../providers/app_provider.dart';

class NavItemMobile extends ConsumerWidget {
  const NavItemMobile({super.key, required this.index, required this.title});
  final int index;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode =
        Theme.of(context).colorScheme.brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        ref.read(appProvider.notifier).scrollTo(index, context);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.only(bottom: 2),
        width: double.infinity,
        color: isDarkMode ? graySwatch.shade800 : graySwatch.shade200,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}

class NavItem extends ConsumerWidget {
  const NavItem({super.key, required this.index, required this.title});
  final int index;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(appProvider.notifier).scrollTo(index, context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}
