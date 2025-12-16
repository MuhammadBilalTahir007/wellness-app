
enum WorkoutType { arms, legs, other }

class TrainingWorkout {
  final String id;
  final String title;
  final String duration; // e.g. "25m - 30m"
  final WorkoutType type;
  final bool isCompleted;

  TrainingWorkout({
    required this.id,
    required this.title,
    required this.duration,
    required this.type,
    this.isCompleted = false,
  });
}

class TrainingDay {
  final DateTime date; // e.g. Dec 8
  final String dayName; // e.g. Mon
  final List<TrainingWorkout> workouts;

  TrainingDay({
    required this.date,
    required this.dayName,
    this.workouts = const [],
  });
}
