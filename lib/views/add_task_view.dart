import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_student_task_manager/views/home_view.dart';
import '../task_controller.dart';

class AddTaskView extends StatelessWidget {
  AddTaskView({super.key});

  final TaskController taskController = Get.find<TaskController>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rx<TaskPriority> selectedPriority = TaskPriority.Normal.obs;

  @override
  Widget build(BuildContext context) {
    final size = Get.mediaQuery.size;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text("Add New Task"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Create Task ✨",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text(
                "Add task details below to stay organized",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Task Name
              const Text("Task Name", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              TextFormField(
                controller: titleController,
                validator: (value) =>
                value == null || value.trim().isEmpty ? "Task name required" : null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.edit, color: Colors.blue),
                  hintText: "Enter task name",
                  filled: true,
                  fillColor: Colors.blue.shade50.withOpacity(0.5),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),

              // Task Description
              const Text("Task Description", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              TextFormField(
                controller: descController,
                maxLines: 4,
                validator: (value) => value == null || value.trim().isEmpty
                    ? "Task description required"
                    : null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.notes, color: Colors.blueAccent),
                  hintText: "Describe your task",
                  filled: true,
                  fillColor: Colors.blue.shade50.withOpacity(0.5),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),

              // Priority Dropdown
              const Text("Priority", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Obx(() => DropdownButtonFormField<TaskPriority>(
                value: selectedPriority.value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue.shade50.withOpacity(0.5),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: TaskPriority.values.map((priority) {
                  Color color = Colors.grey;
                  if (priority == TaskPriority.High) color = Colors.red;
                  if (priority == TaskPriority.Normal) color = Colors.orange;
                  if (priority == TaskPriority.Low) color = Colors.green;

                  return DropdownMenuItem(
                    value: priority,
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 8),
                        Text(priority.name),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) selectedPriority.value = value;
                },
              )),

              const SizedBox(height: 30),

              SizedBox(
                width: size.width,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      taskController.addTask(
                        titleController.text.trim(),
                        descController.text.trim(),
                        selectedPriority.value,
                      );

                      titleController.clear();
                      descController.clear();
                      selectedPriority.value = TaskPriority.Normal;

                      Get.snackbar("Success", "Task added successfully",
                          backgroundColor: Colors.green.shade100,
                          snackPosition: SnackPosition.BOTTOM);

                      Get.to(HomeView(),);
                    }
                  },
                  child: const Text("Add Task",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
