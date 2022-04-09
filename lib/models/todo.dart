class Todo {
  final int? id;
  final int? taskId;
  final String? title;
  final int? isDone;

  Todo({
    this.id,
    this.taskId,
    this.title,
    this.isDone,
  });

  // converting todo obj to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskId': taskId,
      'title': title,
      'isDone': isDone,
    };
  }
}
