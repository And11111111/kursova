class User {
  final String username;
  final String password;

  User({required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  // Convert from map to User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      password: map['password'],
    );
  }
}
