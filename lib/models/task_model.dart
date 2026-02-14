class Task {
  String title;
  bool completed;

  Task({required this.title, this.completed = false});

  Map<String, dynamic> toMap() => {
        'title': title,
        'completed': completed,
      };

  factory Task.fromMap(Map<String, dynamic> map) => Task(
        title: map['title'],
        completed: map['completed'] ?? false,
      );
}