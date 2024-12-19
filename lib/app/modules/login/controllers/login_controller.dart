import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide FormData;
import 'package:soul_sage_web/app/data/api_service/config.dart';
import 'package:soul_sage_web/app/data/api_service/models/user_model.dart';
import 'package:soul_sage_web/app/data/components/Helpers/shared_pref_helper.dart';
import 'package:soul_sage_web/app/data/components/constants.dart';
import 'package:soul_sage_web/app/routes/app_pages.dart';

class LoginController extends GetxController {
  var isPasswordVisible = false.obs; // Observing the password field visibility
  var email = ''.obs;
  var password = ''.obs;
  var rememberMe = false.obs;

  // Toggle visibility of password
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Method for login validation
  Future<void> login() async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return;
    } else {
      FormData data = FormData.fromMap({
        'email': email,
        'password': password,
        'username': "admin",
        'country': 'IN',
        'device_type': 'Web',
        'login_type': 'social',
        'fcm_token': "fcm token"
      });
      await EasyLoading.show();
      await apiCall.postAPICall(
        url: APIConstant.login,
        data: data,
        header: {
          "Content-Type": "multipart/form-data", // Adjust if needed
        },
      ).then(
        (value) async {
          UserModel user = UserModel.fromJson(value.data);
          sharedPref.setCurrentUser(user).then(
            (value) {
              sharedPref.currentSavedUser.then(
                (value) {
                  kToken = user.token;
                  userModel = value;
                  sharedPref.set(SharedPref.isLogin, true).then(
                    (value) {
                      Future.delayed(Duration.zero, () {
                        Get.offAllNamed(Routes.DASHBOARD);
                      });
                    },
                  );
                  update();
                },
              );
            },
          );

          await EasyLoading.dismiss();
        },
      );
    }
    // Perform login API call or navigation
  }
}
