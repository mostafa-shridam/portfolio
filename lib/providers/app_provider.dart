import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/theme_provider.g.dart';

@riverpod
class AppProvider extends _$AppProvider {
  @override
  AppState build() {
    return AppState(
      themeMode: ThemeMode.light,
      scrollController: ScrollController(),
      isMobile: false,
    );
  }

  void toggleTheme() {
    state = AppState(
      themeMode:
          state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
      scrollController: state.scrollController,
      isMobile: state.isMobile,
    );
  }

  void updateLayout(bool isMobile) {
    state = AppState(
      themeMode: state.themeMode,
      scrollController: state.scrollController,
      isMobile: isMobile,
    );
  }

  void scrollTo(int index, BuildContext context) {
    if (state.scrollController.hasClients) {
      final screenHeight = MediaQuery.of(context).size.height;
      final offset = state.isMobile
          ? index * screenHeight * 0.6 // Slightly less for mobile
          : index * screenHeight * 0.7;

      state.scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}

class AppState {
  final ThemeMode? themeMode;
  final ScrollController scrollController;
  final bool isMobile;

  AppState({
    this.themeMode,
    required this.scrollController,
    this.isMobile = false,
  });
}
