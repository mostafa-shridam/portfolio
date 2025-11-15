import 'package:flutter/material.dart';

enum TempIcon {
  modernMinimalist,
  creativePortfolio,
  professional,
  developerFocus,
  photography,
  interactive,
  graphicDesigner,
  uiuxDesigner,
  dataScientist,
  marketer;

  static IconData byIndex(int index) {
    switch (index) {
      case 0:
        return Icons.web;
      case 1:
        return Icons.palette;
      case 2:
        return Icons.business_center;
      case 3:
        return Icons.code;
      case 4:
        return Icons.photo_camera;
      case 5:
        return Icons.touch_app;
      case 6:
        return Icons.design_services;
      case 7:
        return Icons.brush;
      case 8:
        return Icons.movie_filter;
      case 9:
        return Icons.smartphone;
      case 10:
        return Icons.language;
      case 11:
        return Icons.mic;
      case 12:
        return Icons.view_in_ar;
      case 13:
        return Icons.devices_other;
      case 14:
        return Icons.analytics;
      case 15:
        return Icons.person;
      default:
        return Icons.web;
    }
  }
}
