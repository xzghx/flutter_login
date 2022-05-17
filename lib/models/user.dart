class User {
  final int id;
  final String name;
  final String lastName;

  static const empty = User(id: 0, name: '_', lastName: '_');

  const User({
    required this.id,
    required this.name,
    required this.lastName,
  });
}
