import 'package:get/get.dart';

// Task Priority Enum
enum TaskPriority { High, Normal, Low }

// Task Model
class Task {
  String title;
  String description;
  TaskPriority priority;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    this.priority = TaskPriority.Normal,
    this.isCompleted = false,
  });
}

// Task Controller
class TaskController extends GetxController {
  var tasks = <Task>[].obs; // RxList<Task>

  // Add a new task
  void addTask(String title, String description, TaskPriority priority) {
    tasks.add(Task(title: title, description: description, priority: priority));
  }

  // Toggle completed
  void toggleTask(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    tasks.refresh();
  }

  // Delete a task
  void deleteTask(int index) {
    tasks.removeAt(index);
  }
}
