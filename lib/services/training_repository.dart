import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/training_models.dart';

class TrainingRepository extends ChangeNotifier {
  static final TrainingRepository _instance = TrainingRepository._internal();

  factory TrainingRepository() {
    return _instance;
  }

  TrainingRepository._internal();

  SharedPreferences? _prefs;
  // Key: "YYYY-MM-DD", Value: List of Workouts
  Map<String, List<TrainingWorkout>> _workoutMap = {};

  final String _storageKey = 'training_data_v1';

  Future<void> init() async {
    if (_prefs != null) return;
    _prefs = await SharedPreferences.getInstance();
    _loadData();
  }

  void _loadData() {
    final String? jsonString = _prefs?.getString(_storageKey);
    if (jsonString != null) {
      try {
        final Map<String, dynamic> decoded = jsonDecode(jsonString);
        _workoutMap = decoded.map((key, value) {
          final List<dynamic> list = value as List<dynamic>;
          return MapEntry(
            key,
            list.map((item) => _fromJson(item)).toList(),
          );
        });
      } catch (e) {
        print('Error parsing training data: $e');
        _initializeDefaults();
      }
    }

    if (_workoutMap.isEmpty) {
      _initializeDefaults();
    }
    notifyListeners();
  }

  Future<void> _saveData() async {
    final Map<String, dynamic> encoded = _workoutMap.map((key, value) {
      return MapEntry(
        key,
        value.map((w) => _toJson(w)).toList(),
      );
    });
    await _prefs?.setString(_storageKey, jsonEncode(encoded));
    notifyListeners();
  }

  void _initializeDefaults() {
    // Default Data for Current Week
    DateTime now = DateTime.now();
    // Find Monday of this week
    int daysToSubtract = now.weekday - 1;
    DateTime monday = now.subtract(Duration(days: daysToSubtract));
    DateTime thursday = monday.add(const Duration(days: 3));

    _addWorkout(monday, TrainingWorkout(
      id: '1',
      title: 'Arm Blaster',
      duration: '25m - 30m',
      type: WorkoutType.arms,
      isCompleted: true,
    ));

    _addWorkout(thursday, TrainingWorkout(
      id: '2',
      title: 'Leg Day Blitz',
      duration: '25m - 30m',
      type: WorkoutType.legs,
    ));
    
    // Save defaults immediately
    _saveData();
  }

  void _addWorkout(DateTime date, TrainingWorkout workout) {
    String key = _dateKey(date);
    if (!_workoutMap.containsKey(key)) {
      _workoutMap[key] = [];
    }
    _workoutMap[key]!.add(workout);
  }

  // --- Public API ---

  List<TrainingWorkout> getWorkoutsForDate(DateTime date) {
    return _workoutMap[_dateKey(date)] ?? [];
  }

  Future<void> moveWorkout(TrainingWorkout workout, DateTime fromDate, DateTime toDate) async {
    String fromKey = _dateKey(fromDate);
    String toKey = _dateKey(toDate);

    // Remove from source
    if (_workoutMap.containsKey(fromKey)) {
      _workoutMap[fromKey]!.removeWhere((w) => w.id == workout.id);
    }

    // Add to target
    if (!_workoutMap.containsKey(toKey)) {
      _workoutMap[toKey] = [];
    }
    _workoutMap[toKey]!.add(workout);

    await _saveData();
  }
  
  // Helpers
  String _dateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  // JSON Serialization Helpers (Manual implementation for simplicity)
  Map<String, dynamic> _toJson(TrainingWorkout w) {
    return {
      'id': w.id,
      'title': w.title,
      'duration': w.duration,
      'type': w.type.index, // Store enum index
      'isCompleted': w.isCompleted,
    };
  }

  TrainingWorkout _fromJson(Map<String, dynamic> json) {
    return TrainingWorkout(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      type: WorkoutType.values[json['type'] ?? 0],
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
