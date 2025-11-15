import 'package:flutter/cupertino.dart';

class TempleteModel {
  final String title;
  final String description;
  final IconData icon;
  final int color;
  final String badge;
  final List<String> features;

  TempleteModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.badge,
    required this.features,
  });
  factory TempleteModel.fromJson(Map<String, dynamic> json) {
    return TempleteModel(
      title: json['title'],
      description: json['description'],
      icon: json['icon'],
      color: json['color'],
      badge: json['badge'],
      features: json['features'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'icon': icon,
      'color': color,
      'badge': badge,
      'features': features,
    };
  }
}
