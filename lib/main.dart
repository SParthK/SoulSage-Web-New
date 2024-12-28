import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

import 'app/app_bindings.dart';
import 'app/data/api_service/api_provider.dart';
import 'app/data/api_service/config.dart';
import 'app/data/components/Helpers/shared_pref_helper.dart';
import 'app/data/components/app_color.dart';
import 'app/routes/app_pages.dart';

GetIt sl = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Dependency injection using GetIt
  setupDependencies();

  // Configuring loag screen
  configLoading();

  // Fetch user info and initial route before running the app
  await _initializeApp();

  runApp(MyApp());
}

void setupDependencies() {
  sl.registerLazySingleton<SharedPref>(() => SharedPref());
  sl.registerLazySingleton<APIProvider>(() => APIProvider());
}

Future<void> _initializeApp() async {
  await GetStorage.init();
  await getCurrentUser();
  await fetchInitialRoute();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: EasyLoading.init(),
          // Integrating EasyLoading globally
          initialBinding: AppBinding(),
        );
      },
    );
  }
}

Future<void> fetchInitialRoute() async {
  log("Fetching Initial Route");

  final bool isLoggedIn =
      await sl<SharedPref>().get(SharedPref.isLogin, defaultValue: false);

  if (isLoggedIn) {
    AppPages.INITIAL = Routes.DASHBOARD;
  } else {
    AppPages.INITIAL = Routes.LOGIN;
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 50.0
    ..radius = 10.0
    ..progressColor = AppColors.appColor
    ..backgroundColor = AppColors.appIconColor
    ..indicatorColor = Colors.black
    ..textColor = Colors.black
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..dismissOnTap = false;
}

Future<void> getCurrentUser() async {
  final user = await sl<SharedPref>().currentSavedUser;
  if (user != null) {
    userModel = user; // Assigning the fetched user to a global variable
  }
}
