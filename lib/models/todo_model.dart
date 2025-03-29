class Todo {
  final String title;
  final String description;
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;
  final bool allDay;
  final String priority;
  final String status;
  final String userRef;

  Todo({
    required this.title,
    required this.description,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.allDay,
    required this.priority,
    required this.status,
    required this.userRef,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      description: json['description'],
      startDate: json['startDate'],
      startTime: json['startTime'],
      endDate: json['endDate'],
      endTime: json['endTime'],
      allDay: json['allDay'],
      priority: json['priority'],
      status: json['status'],
      userRef: json['userRef'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'startDate': startDate,
      'startTime': startTime,
      'endDate': endDate,
      'endTime': endTime,
      'allDay': allDay,
      'priority': priority,
      'status': status,
      'userRef': userRef,
    };
  }
}
