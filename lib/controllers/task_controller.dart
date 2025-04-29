import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/task_model.dart';

enum TaskTab { pending, completed }

class TaskController extends GetxController {
  RxList<Task> tasks = <Task>[].obs;
  final String _storageKey = 'tasks';
  var selectedTab = TaskTab.pending.obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  List<Task> get filteredTasks {
    if (selectedTab.value == TaskTab.pending) {
      return tasks.where((t) => !t.isDone).toList();
    } else {
      return tasks.where((t) => t.isDone).toList();
    }
  }

  void changeTab(TaskTab tab) {
    selectedTab.value = tab;
  }

  void addTask(String title) {
    tasks.add(Task(title: title));
    saveTasks();
  }

  void toggleTask(int index) {
    final task = tasks[index];
    task.isDone = !task.isDone;
    tasks[index] = task;
    saveTasks();
  }

  void saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = tasks.map((task) => jsonEncode(task.toMap())).toList();
    await prefs.setStringList(_storageKey, taskList);
  }

  void loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_storageKey);
    if (stored != null) {
      try {
        tasks.value = stored.map((e) => Task.fromMap(jsonDecode(e))).toList();
      } catch (e) {
        tasks.clear();
        // Log or handle error
      }
    }
  }
}
