import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_student_task_manager/task_controller.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
  Get.put(TaskController(),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Smart Student Task Manager',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.pages,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
