import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../data/components/app_color.dart';
import '../../UserManagement/bindings/user_management_binding.dart';
import '../../UserManagement/controllers/user_management_controller.dart';

class DashboardController extends GetxController {
  var selectedPage = 0.obs;

  final List<String> options = [
    'User Management',
    'Add Chapter',
    'Add Question',
    'Subscription Details'
  ];

  TextEditingController searchField = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    changePage(0);
  }

  void changePage(int index) async {
    log("message-==-----S");
    if (index == 0) {
      Get.lazyPut<UserManagementController>(
        () => UserManagementController(),
      );
      await Get.find<UserManagementController>().getUserList();
    }
    selectedPage.value = index;
    update();
  }

  Widget SideBarButton(
      {required final String title,
      required final int pageIndex,
      required final bool isSelected}) {
    return GestureDetector(
      onTap: () =>
          Get.find<DashboardController>().changePage(selectedPage.value),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
        padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.appColor.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.appColor : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
