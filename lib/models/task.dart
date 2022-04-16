class Task {
  final int id;
  final String title;

  Task({
    required this.id,
    required this.title,
  });

  // converting task obj to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}
