import 'package:flutter/material.dart';

enum MoodType {
  calm,
  peaceful,
  content,
  happy,
}

class MoodState {
  final MoodType type;
  final String label;
  final String svgAsset;
  final Color color;
  final double startAngle; // In radians
  final double endAngle;   // In radians

  const MoodState({
    required this.type,
    required this.label,
    required this.svgAsset,
    required this.color,
    required this.startAngle,
    required this.endAngle,
  });

  bool containsAngle(double angle) {
    // Normalize angle to 0-2π range
    double normalized = angle % (2 * 3.14159);
    if (normalized < 0) normalized += 2 * 3.14159;
    
    return normalized >= startAngle && normalized < endAngle;
  }
}
