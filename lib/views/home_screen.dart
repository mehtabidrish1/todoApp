import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';
import '../widgets/add_task_dialog.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
  final taskController = Get.put(TaskController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text('To-Do List'),
          centerTitle: true,
        ),
        body: Obx(() => taskController.filteredTasks.isEmpty
            ? const Center(child: Text('No tasks'))
            : ListView.builder(
                itemCount: taskController.filteredTasks.length,
                itemBuilder: (_, index) {
                  final filteredTask = taskController.filteredTasks[index];
                  final actualIndex =
                      taskController.tasks.indexOf(filteredTask);
                  return TaskTile(task: filteredTask, index: actualIndex);
                },
              )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddTaskDialog(context);
          },
          child: const Icon(Icons.add, size: 28),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 4.0,
          child: Obx(() {
            final isPendingActive =
                taskController.selectedTab.value == TaskTab.pending;

            return Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Material(
                      color: isPendingActive
                          ? Theme.of(context).primaryColor.withOpacity(0.85)
                          : Theme.of(context).primaryColor,
                      elevation: isPendingActive ? 0 : 4,
                      child: InkWell(
                        onTap: () => taskController.changeTab(TaskTab.pending),
                        child: const Center(
                          child: Text(
                            'Pending',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Material(
                      color: !isPendingActive
                          ? Theme.of(context).primaryColor.withOpacity(0.85)
                          : Theme.of(context).primaryColor,
                      elevation: !isPendingActive ? 0 : 4,
                      child: InkWell(
                        onTap: () =>
                            taskController.changeTab(TaskTab.completed),
                        child: const Center(
                          child: Text(
                            'Completed',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
