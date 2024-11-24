import 'package:flutter/material.dart';
import '../services/db_service.dart'; // імпортуємо DBService для роботи з базою даних

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final DBService _dbService = DBService(); // Ініціалізуємо службу бази даних

  // Логіка для реєстрації користувача
  Future<void> _register() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in both fields')),
      );
      return;
    }

    // Перевіряємо, чи вже є користувач з таким іменем
    final existingUser = await _dbService.validateUser(username, password);
    if (existingUser) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User already exists')),
      );
      return;
    }

    // Створюємо картку для користувача
    final user = {
      'username': username,
      'password': password,
    };

    // Додаємо користувача в базу даних
    await _dbService.insertUser(user);

    // Повідомлення про успіх
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User registered successfully!')),
    );

    // Повернення на екран авторизації
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
