class Todo {
  String? id;
  String title;
  String? description;
  String category;
  String startTime;
  String userId;
  bool isCompleted;
  DateTime createdAt;
  DateTime updatedAt;

  Todo({
    this.id,
    required this.title,
    this.description,
    required this.category,
    this.isCompleted = false,
    required this.startTime,
    required this.userId,
    DateTime? createdAt, // datetime boleh null
    DateTime? updatedAt,
  })  : this.createdAt = createdAt ?? DateTime.now(),
        this.updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'startTime': startTime,
      'userId': userId,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      startTime: json['startTime'],
      userId: json['userId'],
      isCompleted: json['isCompleted'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
