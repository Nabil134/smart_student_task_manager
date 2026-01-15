import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../task_controller.dart';
import '../routes/app_routes.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final TaskController taskController = Get.put(TaskController()); // singleton

  @override
  Widget build(BuildContext context) {
    final size = Get.mediaQuery.size;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Smart Student Tasks"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Obx(() {
        if (taskController.tasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.task_alt, size: 80, color: Colors.blueAccent),
                SizedBox(height: 20),
                Text("No tasks yet", style: TextStyle(fontSize: 18, color: Colors.grey)),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index]; // Task object

            Color priorityColor = Colors.grey;
            if (task.priority == TaskPriority.High) priorityColor = Colors.red;
            if (task.priority == TaskPriority.Normal) priorityColor = Colors.orange;
            if (task.priority == TaskPriority.Low) priorityColor = Colors.green;

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: task.isCompleted ? Colors.grey.shade300 : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Checkbox
                  GestureDetector(
                    onTap: () => taskController.toggleTask(index),
                    child: Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        color: task.isCompleted ? Colors.blue : Colors.transparent,
                        border: Border.all(
                          color: task.isCompleted ? Colors.blue : Colors.grey.shade400,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: task.isCompleted
                          ? const Icon(Icons.check, color: Colors.white, size: 20)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Task info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                            )),
                        const SizedBox(height: 4),
                        Text(task.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                            )),
                      ],
                    ),
                  ),

                  // Priority badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: priorityColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(task.priority.name,
                        style: TextStyle(
                          color: priorityColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        )),
                  ),

                  const SizedBox(width: 12),

                  // Delete icon
                  GestureDetector(
                    onTap: () => taskController.deleteTask(index),
                    child: const Icon(Icons.delete_outline, color: Colors.redAccent),
                  ),
                ],
              ),
            );
          },
        );
      }),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.addTask),
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}
