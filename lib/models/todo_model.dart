/*
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
*/

class Todo {
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String status;
  final String priority;
  final bool allDay;
  final String userRef;

  Todo({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.priority,
    required this.allDay,
    required this.userRef,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      description: json['description'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      status: json['status'],
      priority: json['priority'],
      allDay: json['allDay'],
      userRef: json['userRef'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'startTime': startTime,
      'endTime': endTime,
      'status': status,
      'priority': priority,
      'allDay': allDay,
      'userRef': userRef,
    };
  }
}