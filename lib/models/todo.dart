class Todo {
  final int id;
  final int taskId;
  final String title;
  final int isDone;
  final String createdDate;


  Todo({
    required this.id,
    required this.taskId,
    required this.title,
    required this.isDone,
    required this.createdDate,

  });

  // converting todo obj to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskId': taskId,
      'title': title,
      'isDone': isDone,
      'createdDate':createdDate,
    };
  }
}
