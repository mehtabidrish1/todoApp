import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../models/task_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final int index;

  const TaskTile({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    final taskController = Get.find<TaskController>();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: CheckboxListTile(
        value: task.isDone,
        onChanged: (_) => taskController.toggleTask(index),
        title: Text(
          task.title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
