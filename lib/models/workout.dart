class Workout {
  final int? id;
  final String date;
  final String exerciseName;
  final int repetitions;
  final double weight;

  Workout({
    this.id,
    required this.date,
    required this.exerciseName,
    required this.repetitions,
    required this.weight,
  });

  // Convert a Workout into a Map
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'exercise_name': exerciseName,
      'repetitions': repetitions,
      'weight': weight,
    };
  }

  // Convert a Map into a Workout
  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      date: map['date'],
      exerciseName: map['exercise_name'],
      repetitions: map['repetitions'],
      weight: map['weight'],
    );
  }
}
