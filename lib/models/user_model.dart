import 'task_model.dart';

class UserModel {
  String name;
  int age;
  int coins;
  int xp;
  int level;
  List<Task> tasks;
  List<String> favoriteQuotes;

  UserModel({
    required this.name,
    required this.age,
    this.coins = 0,
    this.xp = 0,
    this.level = 1,
    List<Task>? tasks,
    List<String>? favoriteQuotes,
  })  : tasks = tasks ?? [],
        favoriteQuotes = favoriteQuotes ?? [];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'coins': coins,
      'xp': xp,
      'level': level,
      'tasks': tasks.map((t) => t.toMap()).toList(),
      'favoriteQuotes': favoriteQuotes,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      age: map['age'],
      coins: map['coins'] ?? 0,
      xp: map['xp'] ?? 0,
      level: map['level'] ?? 1,
      tasks: (map['tasks'] as List<dynamic>?)
              ?.map((t) => Task.fromMap(Map<String, dynamic>.from(t)))
              .toList() ??
          [],
      favoriteQuotes: List<String>.from(map['favoriteQuotes'] ?? []),
    );
  }
}