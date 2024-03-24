import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../manage/controller/task_controller.dart';
import '../../../manage/models/task.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController taskController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isFavorite = false;

  void addTask() {
    if (titleController.text.isEmpty) {
      // Hiển thị lỗi nếu tiêu đề trống
      showToastificationError('Please enter a title for the task');
      return;
    }

    Task newTask = Task(
      createdAt: DateTime.now(),
      title: titleController.text,
      description: descriptionController.text,
      isFavorite: isFavorite,
      done: false,
      id: Task.generateId(),
    );
    taskController.addTask(newTask);
    Get.back(); // Quay lại trang trước

    // Hiển thị thông báo thành công
    showToastificationSuccess('Task added successfully!');
  }

  void showToastificationError(String message) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      title: const Text('Error'),
      description: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
      // Các cài đặt khác của toastification
    );
  }

  void showToastificationSuccess(String message) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      title: const Text('Success'),
      description: Text(message),
      autoCloseDuration: const Duration(seconds: 5),
      // Các cài đặt khác của toastification
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add New Task',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: isFavorite,
                    onChanged: (newValue) {
                      setState(() {
                        isFavorite = newValue ?? false;
                      });
                    },
                  ),
                  const Text('Mark as Favorite'),
                ],
              ),
              ElevatedButton(
                onPressed: addTask,
                child: const Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
