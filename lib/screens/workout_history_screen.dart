import 'package:flutter/material.dart';
import '../services/db_service.dart'; // Імпортуємо DBService для доступу до бази даних

class WorkoutHistoryScreen extends StatefulWidget {
  @override
  _WorkoutHistoryScreenState createState() => _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  final DBService _dbService = DBService();
  List<Map<String, dynamic>> _workouts = [];

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  // Завантажуємо історію тренувань
  Future<void> _loadWorkouts() async {
    final workouts = await _dbService.getWorkouts();
    setState(() {
      _workouts = workouts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout History'),
      ),
      body: _workouts.isEmpty
          ? Center(child: Text('No workouts found'))
          : ListView.builder(
        itemCount: _workouts.length,
        itemBuilder: (context, index) {
          final workout = _workouts[index];
          return ListTile(
            title: Text(workout['workout_name']),
            subtitle: Text('Date: ${workout['date']}'),
            trailing: Text('Reps: ${workout['reps']} x ${workout['weight']} kg'),
          );
        },
      ),
    );
  }
}
