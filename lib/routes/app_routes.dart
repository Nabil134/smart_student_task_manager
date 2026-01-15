import 'package:get/get.dart';
import 'package:smart_student_task_manager/views/add_task_view.dart';

import '../views/signup_view.dart';

class AppRoutes {
  // Route Names
  static const String login = '/login';
  static const String home = '/home';
  static const String addTask = '/addtask';

  // Pages List
  static final List<GetPage> pages = [
    GetPage(
      name: login,
      page: () => const LoginView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: addTask,
      page: () =>  AddTaskView(),
      transition: Transition.fadeIn,
    ),

  ];
}
