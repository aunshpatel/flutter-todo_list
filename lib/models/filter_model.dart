class TodoFilters {
  final String status;
  final String priority;
  final String startDateOrder;
  final String statusOrder;
  final String priorityOrder;

  const TodoFilters({
    this.status = "",
    this.priority = "",
    this.startDateOrder = "",
    this.statusOrder = "",
    this.priorityOrder = "",
  });

  // Add the copyWith method
  TodoFilters copyWith({
    String? status,
    String? priority,
    String? startDateOrder,
    String? statusOrder,
    String? priorityOrder,
  }) {
    return TodoFilters(
      status: status ?? this.status,
      priority: priority ?? this.priority,
      startDateOrder: startDateOrder ?? this.startDateOrder,
      statusOrder: statusOrder ?? this.statusOrder,
      priorityOrder: priorityOrder ?? this.priorityOrder,
    );
  }
}
