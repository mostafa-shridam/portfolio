import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    // Use different physics based on platform
    if (kIsWeb) {
      return const BouncingScrollPhysics().applyTo(
        const AlwaysScrollableScrollPhysics(),
      );
    }
    return const BouncingScrollPhysics();
  }

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // Customize scrollbar appearance
    return Scrollbar(
      controller: details.controller,
      thickness: 6.0,
      radius: const Radius.circular(10.0),
      thumbVisibility: true,
      child: child,
    );
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // Use platform-specific overscroll indicators
    return GlowingOverscrollIndicator(
      axisDirection: details.direction,
      color: Theme.of(context).colorScheme.primary.withAlpha(20),
      child: child,
    );
  }
}
