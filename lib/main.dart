import 'package:flutter/material.dart';
import 'screens/login_screen.dart'; // імпорт екрану авторизації
import 'screens/home_screen.dart';  // імпорт головного екрану

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // Головна точка входу
      routes: {
        '/home': (context) => HomeScreen(), // Додатковий маршрут для головного екрану
      },
    );
  }
}
