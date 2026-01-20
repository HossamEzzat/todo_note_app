class TaskModel {
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  bool isCompleted;

  TaskModel({
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isCompleted = false,
  });

  // Convert a Map (from JSON) into a TaskModel object
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskName: json['taskName'] ?? '',
      taskDescription: json['taskDescription'] ?? '',
      isHighPriority: json['isHighPriority'] ?? false,
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  // Convert a TaskModel object into a Map (to be encoded to JSON)
  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
      'isCompleted': isCompleted,
    };
  }
}
