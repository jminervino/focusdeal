import 'package:flutter/material.dart';
import 'package:todo_list/core/models/tasks/tasks.dart';
import 'package:todo_list/core/services/task_service.dart';

class TaskController extends ChangeNotifier {
  final TaskService taskService = TaskService();

  List<Tasks> _tasks = [];

  List<Tasks> get tasks => _tasks;

  Future<void> createTask(Tasks task) async {
    await taskService.create(task);
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> getTask() async {
    _tasks = await taskService.get();
    notifyListeners();
  }

  Future<void> updateTask(Tasks infos) async {
    await taskService.update(infos.toMap());
    // notifyListeners();
  }

  Future<void> deleteTask(String taskId) async {
    await taskService.delete(taskId);
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }
}
