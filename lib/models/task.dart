class Task {
  final int? id;
  final String? title;
  final String? description;

  Task({
    this.id,
    this.title,
    this.description,
  });

  // converting task obj to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
