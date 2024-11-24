import 'package:flutter/material.dart';
import 'add_workout_screen.dart'; // імпортуємо екран для додавання тренування
import 'workout_history_screen.dart'; // імпортуємо екран для історії тренувань

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome to your workout tracker!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Перехід на екран додавання тренування
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddWorkoutScreen()),
                );
              },
              child: Text('Add New Workout'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Перехід на екран перегляду історії тренувань
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkoutHistoryScreen()),
                );
              },
              child: Text('View Workout History'),
            ),
          ],
        ),
      ),
    );
  }
}
