import 'package:get/get.dart';

import '../modules/AddChapter/bindings/add_chapter_binding.dart';
import '../modules/AddChapter/views/add_chapter_view.dart';
import '../modules/AddQuestion/bindings/add_question_binding.dart';
import '../modules/AddQuestion/views/add_question_view.dart';
import '../modules/Dashboard/bindings/dashboard_binding.dart';
import '../modules/Dashboard/views/dashboard_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/SubscriptionDetails/bindings/subscription_details_binding.dart';
import '../modules/SubscriptionDetails/views/subscription_details_view.dart';
import '../modules/UserManagement/bindings/user_management_binding.dart';
import '../modules/UserManagement/views/user_management_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.USER_MANAGEMENT,
      page: () => UserManagementView(),
      binding: UserManagementBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CHAPTER,
      page: () => AddChapterView(),
      binding: AddChapterBinding(),
    ),
    GetPage(
      name: _Paths.ADD_QUESTION,
      page: () => AddQuestionView(),
      binding: AddQuestionBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION_DETAILS,
      page: () => SubscriptionDetailsView(),
      binding: SubscriptionDetailsBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
  ];
}
