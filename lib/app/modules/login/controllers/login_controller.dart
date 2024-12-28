import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide FormData;
import 'package:soul_sage_web/app/data/model/request/login_request.dart';
import 'package:soul_sage_web/app/data/model/response/login_response.dart';
import 'package:soul_sage_web/app/data/repository/auth_repository.dart';
import 'package:soul_sage_web/app/routes/app_pages.dart';

import '../../../../utils/app_utils.dart';
import '../../../data/get_storage/get_storage.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
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
      try {
        await EasyLoading.show();
        final response = await _authRepository.logIn(
          data: LoginRequest(email: email.value, password: password.value),
        );
        if (response.data?.success == true && response.data?.data != null) {
          LoginResponse loginData = LoginResponse.fromJson(response.data?.data);
          await GetStorageBox.writeStorage(
              key: GetStorageBox.userToken, value: loginData.token);
          String? userToken = GetStorageBox.getToken();
          log("---------------------$userToken}");
          Get.offAllNamed(Routes.DASHBOARD);
          return response.data?.data;
        } else {
          AppUtils.showToast(msg: response.data?.message ?? '');
        }
        /*    .then(
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
          },
        );*/
      } catch (e) {
        log("message-=----$e");
      } finally {
        update();
        await EasyLoading.dismiss();
      }
    }
    // Perform login API call or navigation
  }
}
