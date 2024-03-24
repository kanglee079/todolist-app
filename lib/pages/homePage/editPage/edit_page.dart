import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../../../manage/controller/task_controller.dart';
import '../../../manage/models/task.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key});

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final String taskId = Get.arguments;

  final TaskController taskController = Get.find();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    final task = taskController.tasks.firstWhere((t) => t.id == taskId);
    titleController = TextEditingController(text: task.title);
    descriptionController = TextEditingController(text: task.description);
    isFavorite = task.isFavorite;
  }

  void updateTask() {
    if (titleController.text.isEmpty) {
      showToastificationError('Please enter a title for the task');
      return;
    }

    taskController.updateTask(
      taskId,
      Task(
        id: taskId,
        createdAt: DateTime.now(),
        title: titleController.text,
        description: descriptionController.text,
        isFavorite: isFavorite,
        done: false,
      ),
    );
    Get.back(); // Quay lại trang trước
    showToastificationSuccess('Task updated successfully!');
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
            'Edit Task',
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
                onPressed: updateTask,
                child: const Text('Update Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
