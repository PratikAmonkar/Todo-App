import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/todo.dart';

class DatabaseHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), "todo.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
      "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)",
    );
    await db.execute(
      "CREATE TABLE todo(id INTEGER PRIMARY KEY, taskId INTEGER, title TEXT, isDone INTEGER)",
    );
  }

  Future<void> insertTask(Task task) async {
    // int taskId = 0;
    // Database _db = await database();
    await _db?.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTaskTitle(int id, String title) async {
    // Database _db = await database();
    await _db?.rawUpdate(
      "UPDATE tasks SET title = '$title' WHERE id = '$id'",
    );
  }

  Future<void> updateTaskDescription(int id, String description) async {
    // Database _db = await database();
    await _db!.rawUpdate(
      "UPDATE tasks SET description = '$description' WHERE id = '$id'",
    );
  }

  Future<List<Task>> getTasks() async {
    // Database _db = await database();

    List<Map<String, dynamic>> taskMap = await _db!.query('tasks');
    return List.generate(
      taskMap.length,
      (index) {
        return Task(
          id: taskMap[index]['id'],
          title: taskMap[index]['title'],
        );
      },
    );
  }

  Future<void> deleteTask(int id) async {
    // Database _db = await database();
    await _db!.rawDelete(
      "DELETE FROM tasks WHERE id = '$id'",
    );
    await _db!.rawDelete(
      "DELETE FROM todo WHERE taskId = '$id'",
    );
  }

  Future<void> insertTodo(Todo todo) async {
    // Database _db = await database();
    await _db!.insert(
      'todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Todo>> getTodo(int taskId) async {
    // Database _db = await database();
    List<Map<String, dynamic>> todoMap =
        await _db!.rawQuery("SELECT * FROM todo WHERE taskId = $taskId");
    return List.generate(todoMap.length, (index) {
      return Todo(
        id: todoMap[index]['id'],
        title: todoMap[index]['title'],
        taskId: todoMap[index]['taskId'],
        isDone: todoMap[index]['isDone'],
      );
    });
  }

  Future<void> updateTodoDone(int id, int isDone) async {
    // Database _db = await database();
    await _db!.rawUpdate(
      "UPDATE todo SET isDone = '$isDone' WHERE id = '$id'",
    );
  }
}