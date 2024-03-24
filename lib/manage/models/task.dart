class Task {
  String id;
  DateTime createdAt;
  String title;
  String description;
  bool isFavorite;
  bool done;

  Task({
    required this.id,
    required this.createdAt,
    required this.title,
    this.description = '',
    this.isFavorite = false,
    this.done = false,
  });

  // Convert a Task object into a Map object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'title': title,
      'description': description,
      'isFavorite': isFavorite,
      'done': done,
    };
  }

  // Create a Task object from a map
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      title: json['title'],
      description: json['description'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
      done: json['done'] ?? false,
    );
  }

  // Generate a unique ID - can be replaced with a suitable ID generation strategy
  static String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
