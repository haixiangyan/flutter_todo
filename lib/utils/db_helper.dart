import 'package:flutter_todo/models/task.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, desc TEXT)');
        await db.execute('CREATE TABLE todos(id INTEGER PRIMARY KEY, taskId INTEGER, title TEXT, isDone INTEGER)');
      },
      version: 1,
    );
  }

  Future<void> deleteTask(int id) async {
    Database _db = await database();
    await _db.rawUpdate("DELETE FROM tasks WHERE id = '$id'");
    await _db.rawUpdate("DELETE FROM todos WHERE taskId = '$id'");
  }

  Future<void> updateTaskDesc(int id, String desc) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET desc = '$desc' WHERE id = '$id'");
  }

  Future<void> updateTaskTitle(int id, String title) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE tasks SET title = '$title' WHERE id = '$id'");
  }

  Future<void> updateTodoIsDone(int id, int isDone) async {
    Database _db = await database();
    await _db.rawUpdate("UPDATE todos SET isDone = '$isDone' WHERE id = '$id'");
  }

  Future<int> insertTodo(Todo todo) async {
    int todoId = 0;
    Database _db = await database();

    await _db.insert('todos', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace).then((value) {
      todoId = value;
    });

    return todoId;
  }

  Future<int> insertTask(Task task) async {
    int taskId = 0;
    Database _db = await database();

    await _db.insert('tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace).then((value) {
      taskId = value;
    });

    return taskId;
  }

  Future<List<Task>> getTasks() async {
    Database _db = await database();
    List<Map<String, dynamic>> taskMap = await _db.query('tasks');
    return List.generate(taskMap.length, (index) {
      return Task(
        id: taskMap[index]['id'],
        title: taskMap[index]['title'],
        desc: taskMap[index]['desc']
      );
    });
  }

  Future<List<Todo>> getTodos(int taskId) async {
    Database _db = await database();
    List<Map<String, dynamic>> todoMap = await _db.rawQuery('SELECT * FROM todos WHERE taskId = $taskId');
    return List.generate(todoMap.length, (index) {
      return Todo(
        id: todoMap[index]['id'],
        taskId: todoMap[index]['taskId'],
        title: todoMap[index]['title'],
        isDone: todoMap[index]['isDone'],
      );
    });
  }
}
