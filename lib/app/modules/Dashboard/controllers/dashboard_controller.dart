import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../data/components/app_color.dart';

class DashboardController extends GetxController {
  var selectedPage = 0.obs;

  final List<String> options = [
    'User Management',
    'Add Chapter',
    'Add Question',
    'Subscription Details'
  ];


  TextEditingController searchField = TextEditingController();

  void changePage(int index) {
    selectedPage.value = index;
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
