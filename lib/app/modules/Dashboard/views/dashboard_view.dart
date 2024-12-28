import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:soul_sage_web/app/data/components/app_color.dart';
import 'package:soul_sage_web/app/data/components/app_icons_path.dart';
import 'package:soul_sage_web/app/modules/AddChapter/controllers/add_chapter_controller.dart';
import 'package:soul_sage_web/app/modules/AddQuestion/controllers/add_question_controller.dart';
import 'package:soul_sage_web/app/modules/AddQuestion/views/add_question_view.dart';
import 'package:soul_sage_web/app/modules/SubscriptionDetails/views/subscription_details_view.dart';
import 'package:soul_sage_web/app/modules/UserManagement/controllers/user_management_controller.dart';
import 'package:soul_sage_web/app/modules/UserManagement/views/user_management_view.dart';
import '../../AddChapter/views/add_chapter_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: GetBuilder(builder: (DashboardController controller) {
            return Container(
              height: 120,
              color: AppColors.appWhite,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, left: 40),
                    child: Image.asset(AppIcons.appLogo, width: 10.w),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "Dashboard",
                    style: GoogleFonts.poppins(
                        fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Container(
                    width: 25.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100, // Light background color
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 1.w,
                        ),
                        Icon(
                          Icons.search,
                          color: AppColors.appIconColor.withOpacity(0.5),
                          // Light purple icon
                          size: 15.sp, // Responsive icon size
                        ),
                        SizedBox(width: 1.w), // Space between icon and text
                        SizedBox(
                          width: 20.w,
                          child: TextField(
                            controller: controller.searchField,
                            onChanged: (value) {
                              if (value.length > 3) {
                                if (controller.selectedPage.value == 0) {
                                  Get.put(UserManagementController())
                                      .filterUsersByEmail(value);
                                } else if (controller.selectedPage.value == 1) {
                                  Get.put(AddChapterController())
                                      .filterChaptersByName(value);
                                } else if (controller.selectedPage.value == 2) {
                                  Get.put(AddQuestionController())
                                      .filterQuestionsByQuery(value);
                                }
                              } else {
                                if (controller.selectedPage.value == 0) {
                                  Get.put(UserManagementController())
                                      .filterUsersByEmail("");
                                } else if (controller.selectedPage.value == 1) {
                                  Get.put(AddChapterController())
                                      .filterChaptersByName("");
                                } else if (controller.selectedPage.value == 2) {
                                  Get.put(AddQuestionController())
                                      .filterQuestionsByQuery("");
                                }
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Search here...",
                              // Placeholder text
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                // Light purple text
                                fontSize: 12.sp, // Responsive text size
                              ),
                              border:
                                  InputBorder.none, // Remove default underline
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (controller.selectedPage.value == 0)
                    GestureDetector(
                      onTap: () {
                        if (controller.selectedPage.value == 0) {
                          UserManagementController userManagementController =
                              Get.put(UserManagementController());
                          userManagementController.isFilterTrue.value == true;

                          userManagementController.update();

                          userManagementController.showFilterDialog(context);
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Color(0xFF5A00FF),
                          ),
                        ),
                        child: Text(
                          "Filters",
                          style: TextStyle(
                              color: Color(0xFF5A00FF), fontSize: 12.sp),
                        ),
                      ),
                    ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Container(
                    height: 6.h,
                    width: 3.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage(
                              "https://images.pexels.com/photos/1040881/pexels-photo-1040881.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                            ),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Mayank",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Admin",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.appBlack.withOpacity(0.2)),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF5A00FF),
                            Color(0xFF9F00FF),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                ],
              ),
            );
          }),
        ),
        body: GetBuilder(builder: (DashboardController dashboardController) {
          return Row(
            children: [
              Container(
                width: 20.w,
                color: AppColors.appWhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    ...List.generate(dashboardController.options.length,
                        (index) {
                      bool isSelected =
                          dashboardController.selectedPage.value == index;

                      return GestureDetector(
                        onTap: () {
                          dashboardController.changePage(index);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 4),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 1.5.h),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFF5A00FF),
                                        Color(0xFF9F00FF),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(10),
                              // Rounded corners
                              color: isSelected
                                  ? null
                                  : Colors
                                      .transparent, // No color if not selected
                            ),
                            child: Row(
                              children: [
                                Text(
                                  dashboardController.options[index],
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    color: isSelected
                                        ? Colors.white
                                        : AppColors.appBlack.withOpacity(0.7),
                                    // Lighter text if not selected
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // Main content area
              Expanded(
                child: Container(
                  color: AppColors.appGrey.withOpacity(0.2),
                  child: Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Obx(() {
                      // Handle the main content based on selected page
                      switch (controller.selectedPage.value) {
                        case 1:
                          return AddChapterView();
                        case 2:
                          return AddQuestionView();
                        case 3:
                          return SubscriptionDetailsView();
                        default:
                          return UserManagementView();
                      }
                    }),
                  ),
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}
