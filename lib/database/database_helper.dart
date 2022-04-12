import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/todo.dart';

class TodoDatabase {
  static final TodoDatabase instance = TodoDatabase._init();

  static Database? _database;

  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
      "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)",
    );
    await db.execute(
      "CREATE TABLE todo(id INTEGER PRIMARY KEY, taskId INTEGER, title TEXT, isDone INTEGER)",
    );
  }

  Future<int> insertTask(Task task) async {
    final db = await instance.database;
    final id = await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Task>> getTasks() async {
    final db = await instance.database;
    List<Map<String, dynamic>> taskMap = await db.query(
      'tasks',
    );
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

  Future<void> insertTodos(Todo todo) async {
    final db = await instance.database;
    await db.insert(
      'todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Todo>> getTodos(int taskId) async {
    final db = await instance.database;
    List<Map<String, dynamic>> todoMap =
        await db.rawQuery("SELECT * FROM todo WHERE taskId = $taskId");
    return List.generate(
      todoMap.length,
      (index) {
        return Todo(
          id: todoMap[index]['id'],
          title: todoMap[index]['title'],
          taskId: todoMap[index]['taskId'],
          isDone: todoMap[index]['isDone'],
        );
      },
    );
  }

  Future<void> deleteTodo(int id) async {
    final db = await instance.database;
    await db.rawDelete(
      "DELETE FROM todo WHERE taskId = '$id'",
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
