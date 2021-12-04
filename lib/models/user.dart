class User {
  String id;
  String name;
  String email;
  User({
    required this.id,
    required this.name,
    required this.email,
  });
  factory User.fromMap(var data) {
    final Map map = data as Map;
    return User(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
    );
  }
}
