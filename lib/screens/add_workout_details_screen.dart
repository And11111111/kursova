import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/db_service.dart'; // імпортуємо DBService для роботи з базою даних

class AddWorkoutScreen extends StatefulWidget {
  @override
  _AddWorkoutScreenState createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final _workoutNameController = TextEditingController();
  final _repsController = TextEditingController();
  final _weightController = TextEditingController();
  final _dateController = TextEditingController();
  final DBService _dbService = DBService(); // Ініціалізуємо службу бази даних

  @override
  void initState() {
    super.initState();
    // Встановлюємо поточну дату як стандартну
    final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _dateController.text = currentDate;
  }

  // Логіка додавання тренування
  Future<void> _addWorkout() async {
    final workoutName = _workoutNameController.text;
    final reps = int.tryParse(_repsController.text);
    final weight = double.tryParse(_weightController.text);
    final date = _dateController.text;

    if (workoutName.isEmpty || reps == null || weight == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields correctly')),
      );
      return;
    }

    // Створення об'єкта тренування
    final workout = {
      'date': date,
      'workout_name': workoutName,
      'reps': reps,
      'weight': weight,
    };

    // Зберігаємо тренування в базу даних
    await _dbService.insertWorkout(workout);

    // Повідомлення про успіх
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Workout added successfully!')),
    );

    // Повернення на головний екран
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Workout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
              readOnly: true,
            ),
            TextField(
              controller: _workoutNameController,
              decoration: InputDecoration(labelText: 'Workout Name'),
            ),
            TextField(
              controller: _repsController,
              decoration: InputDecoration(labelText: 'Repetitions'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addWorkout,
              child: Text('Add Workout'),
            ),
          ],
        ),
      ),
    );
  }
}
