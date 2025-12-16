class DayModel {
  final DateTime date;
  final bool isSelected;
  final bool hasWorkout; // Green dot
  final bool isToday;

  DayModel({
    required this.date,
    this.isSelected = false,
    this.hasWorkout = false,
    this.isToday = false,
  });
}

class CaloriesData {
  final int consumed;
  final int goal;

  int get remaining => goal - consumed;

  CaloriesData({required this.consumed, required this.goal});
}

class WeightData {
  final double current;
  final double change; // +1.6 etc
  final bool isGain;

  WeightData({required this.current, required this.change, this.isGain = true});
}

class HydrationData {
  final int current; // ml
  final int goal; // ml

  HydrationData({required this.current, required this.goal});
}

class WorkoutData {
  final String title;
  final String subtitle;
  final bool isRestDay;

  WorkoutData({
    required this.title,
    required this.subtitle,
    required this.isRestDay,
  });
}
