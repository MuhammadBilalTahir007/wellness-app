import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/training_models.dart';
import '../services/training_repository.dart';
import '../utils/date_utils.dart';

class TrainingViewModel extends ChangeNotifier {
  List<TrainingDay> _days = [];
  List<TrainingDay> get days => _days;

  final TrainingRepository _repository = TrainingRepository();

  TrainingViewModel() {
    _init();
  }

  Future<void> _init() async {
    await _repository.init();
    _refreshData();
  }

  void _refreshData() {
    DateTime now = DateTime.now();
    List<DateTime> dates = AppDateUtils.getDaysInWeek(now);

    _days = [];
    for (int i = 0; i < dates.length; i++) {
      DateTime date = dates[i];
      _days.add(
        TrainingDay(
          date: date,
          dayName: DateFormat('E').format(date), // Mon, Tue...
          workouts: _repository.getWorkoutsForDate(date),
        ),
      );
    }
    notifyListeners();
  }

  String get weekStr => AppDateUtils.getWeekStr(DateTime.now());

  String get dateRangeStr {
    if (_days.isEmpty) return '';
    DateTime start = _days.first.date;
    DateTime end = _days.last.date;

    if (start.month == end.month) {
      return '${DateFormat('MMMM').format(start)} ${start.day}-${end.day}';
    } else {
      return '${DateFormat('MMM d').format(start)} - ${DateFormat('MMM d').format(end)}';
    }
  }

  Future<void> onWorkoutDropped(
    TrainingWorkout workout,
    DateTime targetDate,
  ) async {
    DateTime? sourceDate;
    for (var day in _days) {
      if (day.workouts.any((w) => w.id == workout.id)) {
        sourceDate = day.date;
        break;
      }
    }

    if (sourceDate != null) {
      await _repository.moveWorkout(workout, sourceDate, targetDate);
      _refreshData();
    }
  }
}
