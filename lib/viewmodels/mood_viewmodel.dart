import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/mood_models.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';

class MoodViewModel extends ChangeNotifier {
  double _currentAngle = 0.0; // Current knob angle in radians
  MoodState _currentMood;

  static final List<MoodState> _moodStates = [
    MoodState(
      type: MoodType.content,
      label: 'Content',
      svgAsset: AppAssets.moodContent,
      color: AppColors.moodContent,
      startAngle: 0,
      endAngle: math.pi / 2,
    ),
    MoodState(
      type: MoodType.peaceful,
      label: 'Peaceful',
      svgAsset: AppAssets.moodPeaceful,
      color: AppColors.moodPeaceful,
      startAngle: math.pi / 2,
      endAngle: math.pi,
    ),
    MoodState(
      type: MoodType.happy,
      label: 'Happy',
      svgAsset: AppAssets.moodHappy,
      color: AppColors.moodHappy,
      startAngle: math.pi,
      endAngle: 3 * math.pi / 2,
    ),
    MoodState(
      type: MoodType.calm,
      label: 'Calm',
      svgAsset: AppAssets.moodCalm,
      color: AppColors.moodCalm,
      startAngle: 3 * math.pi / 2,
      endAngle: 2 * math.pi,
    ),
  ];

  MoodViewModel() : _currentMood = _moodStates[0] {
    _updateMoodFromAngle();
  }

  MoodState get currentMood => _currentMood;
  double get currentAngle => _currentAngle;
  List<MoodState> get moodStates => _moodStates;

  void updateAngle(double angle) {
    _currentAngle = angle;
    _updateMoodFromAngle();
    notifyListeners();
  }

  void _updateMoodFromAngle() {
    // Normalize angle to 0-2π
    double normalized = _currentAngle % (2 * math.pi);
    if (normalized < 0) normalized += 2 * math.pi;

    // Find which mood state this angle belongs to
    for (var mood in _moodStates) {
      if (mood.containsAngle(normalized)) {
        if (_currentMood.type != mood.type) {
          _currentMood = mood;
        }
        break;
      }
    }
  }

  void setMood(MoodType type) {
    final mood = _moodStates.firstWhere((m) => m.type == type);
    _currentMood = mood;
    // Set angle to middle of the mood's range
    _currentAngle = (mood.startAngle + mood.endAngle) / 2;
    notifyListeners();
  }
}
