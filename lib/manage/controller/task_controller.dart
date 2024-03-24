import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:xikang_todolist/apps/route/route_name.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;

  List<Task> get incompleteTasks => tasks.where((task) => !task.done).toList();

  List<Task> get doneTasks => tasks.where((task) => task.done).toList();

  List<Task> get favoriteTasks =>
      tasks.where((task) => task.isFavorite).toList();

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void transToAddPage() {
    Get.toNamed(RouterName.addTaskPage);
  }

  void transToEditPage(String taskId) {
    Get.toNamed(RouterName.editTaskPage, arguments: taskId);
  }

  void addTask(Task task) {
    var uuid = const Uuid();
    Task newTask = Task(
      id: uuid.v4(),
      createdAt: task.createdAt,
      title: task.title,
      description: task.description,
      isFavorite: task.isFavorite,
      done: task.done,
    );
    tasks.add(newTask);
    saveTasks();
  }

  void updateTask(String taskId, Task updatedTask) {
    int taskIndex = tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      tasks[taskIndex] = updatedTask;
      tasks.refresh();
      saveTasks();
    }
  }

  void toggleFavorite(String taskId) {
    int taskIndex = tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      tasks[taskIndex].isFavorite = !tasks[taskIndex].isFavorite;
      tasks.refresh();
      saveTasks();
    }
  }

  void toggleDone(String taskId) {
    int taskIndex = tasks.indexWhere((task) => task.id == taskId);
    if (taskIndex != -1) {
      tasks[taskIndex].done = !tasks[taskIndex].done;
      tasks.refresh();
      saveTasks();
    }
  }

  void deleteTask(String taskId) {
    tasks.removeWhere((task) => task.id == taskId);
    saveTasks();
  }

  void deleteAllDoneTasks() {
    tasks.removeWhere((task) => task.done);
    saveTasks();
  }

  void deleteAllFavoriteTasks() {
    tasks.removeWhere((task) => task.isFavorite);
    saveTasks();
  }

  Future<void> saveTasks() async {
    var prefs = await SharedPreferences.getInstance();
    String jsonTasks = jsonEncode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString('tasks', jsonTasks);
  }

  Future<void> loadTasks() async {
    var prefs = await SharedPreferences.getInstance();
    String? jsonTasks = prefs.getString('tasks');

    if (jsonTasks != null) {
      List<dynamic> taskList = jsonDecode(jsonTasks);
      tasks.value = taskList.map((json) => Task.fromJson(json)).toList();
    }
  }
}
