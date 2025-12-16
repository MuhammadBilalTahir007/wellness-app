import 'package:flutter/material.dart';
import '../models/home_models.dart';
import '../utils/date_utils.dart';
import '../services/training_repository.dart';
import '../models/training_models.dart';

class HomeViewModel extends ChangeNotifier {
  // Calendar Data
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  List<DayModel> _days = [];
  List<DayModel> get days => _days;

  // Insight Data
  CaloriesData _caloriesData = CaloriesData(consumed: 0, goal: 2000);
  WeightData _weightData = WeightData(current: 0, change: 0);
  HydrationData _hydrationData = HydrationData(current: 0, goal: 2000);
  WorkoutData? _currentWorkout;

  CaloriesData get caloriesData => _caloriesData;
  WeightData get weightData => _weightData;
  HydrationData get hydrationData => _hydrationData;
  WorkoutData? get currentWorkout => _currentWorkout;
  
  final TrainingRepository _repository = TrainingRepository();

  HomeViewModel() {
    _init();
  }
  
  Future<void> _init() async {
    _repository.addListener(_onRepoChanged);
    await _repository.init();
    _initializeData();
  }
  
  void _onRepoChanged() {
    _updateDaysForWeek(_selectedDate);
    _updateWorkoutForDate(_selectedDate);
    notifyListeners();
  }
  
  @override
  void dispose() {
    _repository.removeListener(_onRepoChanged);
    super.dispose();
  }

  void _initializeData() {
    _selectedDate = DateTime.now();
    _updateDaysForWeek(_selectedDate);
    _updateWorkoutForDate(_selectedDate);

    _caloriesData = CaloriesData(consumed: 550, goal: 2500);
    _weightData = WeightData(current: 75, change: 1.6, isGain: true);
    _hydrationData = HydrationData(current: 500, goal: 2000);
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    _updateDaysForWeek(date);
    _updateWorkoutForDate(date);
    notifyListeners();
  }

  void _updateWorkoutForDate(DateTime date) {
    List<TrainingWorkout> workouts = _repository.getWorkoutsForDate(date);
    
    if (workouts.isNotEmpty) {
      // Show the first workout
      TrainingWorkout first = workouts.first;
      String month = _getMonthName(date.month);
      // Subtitle: "Dec 12 - 30m" (Approx duration from string)
      // Duration string in model is "25m - 30m", let's just use it or a part.
      String subtitle = '$month ${date.day} - ${first.duration}';
      
      _currentWorkout = WorkoutData(
        title: first.title, 
        subtitle: subtitle,
        isRestDay: false,
      );
    } else {
      // Rest Day
      String month = _getMonthName(date.month);
      _currentWorkout = WorkoutData(
        title: 'Rest Day', 
        subtitle: '$month ${date.day} - Relax and Recover',
        isRestDay: true,
      );
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return months[month - 1];
  }

  void _updateDaysForWeek(DateTime date) {
    List<DateTime> weekDays = AppDateUtils.getDaysInWeek(date);

    _days = weekDays.map((d) {
      bool hasWorkout = _repository.getWorkoutsForDate(d).isNotEmpty;
      return DayModel(
        date: d,
        isSelected: AppDateUtils.isSameDay(d, _selectedDate),
        hasWorkout: hasWorkout, // Green dot now reflects actual data
        isToday: AppDateUtils.isSameDay(d, DateTime.now()),
      );
    }).toList();
  }

  String get weekStr => AppDateUtils.getWeekStr(_selectedDate);

  void addWater(int amount) {
    int newCurrent = _hydrationData.current + amount;
    if (newCurrent > _hydrationData.goal) newCurrent = _hydrationData.goal;

    _hydrationData = HydrationData(
      current: newCurrent,
      goal: _hydrationData.goal,
    );
    notifyListeners();
  }
}
