import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:soul_sage_web/app/data/api_service/config.dart';
import 'package:soul_sage_web/app/data/components/app_color.dart';
import 'package:soul_sage_web/app/data/components/app_icons_path.dart';
import 'package:soul_sage_web/app/data/components/constants.dart';
import 'package:soul_sage_web/app/data/network/network_request.dart';
import 'package:soul_sage_web/utils/app_utils.dart';

import '../controllers/user_management_controller.dart';

class UserManagementView extends GetView<UserManagementController> {
  UserManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.isTrue
            ? SizedBox.shrink()
            : GetBuilder<UserManagementController>(
                builder: (controller) {
                  // Check if users list is empty to display loading or no data
                  return Obx(
                    () => controller.users.isEmpty
                        ? Center(
                            child: Text(
                              "No Users found",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 2.h,
                              ),
                            ),
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            color: AppColors.appWhite,
                            padding: EdgeInsets.all(2.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CachedNetworkImage(
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      'https://storage.googleapis.com/soulsage-7928d.firebasestorage.app/chapter/test.png',
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) {
                                    print(error);
                                    return const Icon(Icons.error);
                                  },
                                ), // Title
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'User Management',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                    Text(
                                      'Total User : ${controller.filteredUsers.isEmpty ? controller.users.length : controller.filteredUsers.length}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.normal,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                // User Data Table
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        minWidth:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                      ),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          columns:
                                              _buildTableColumns(controller),
                                          rows: _buildTableRows(controller),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  );
                },
              ),
      ),
      bottomNavigationBar: Obx(
        () => controller.users.isEmpty
            ? const SizedBox.shrink()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (controller.userListPageNumber.value > 1) {
                            controller.userListPageNumber.value--;
                            controller.getUserList();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.appColor,
                            border: Border.all(color: AppColors.black),
                          ),
                          child: const Icon(
                            Icons.arrow_left,
                            color: AppColors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Obx(
                          () => Text(
                            "${controller.userListPageNumber.value}/${controller.userListMaxPageNumber.value ?? ""}",
                            // style: Styles.tsBlackMedium16,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if ((controller.userListMaxPageNumber.value ?? 0) >
                              controller.userListPageNumber.value) {
                            controller.userListPageNumber.value++;
                            controller.getUserList();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.appColor,
                            border: Border.all(color: AppColors.black),
                          ),
                          child: const Icon(
                            Icons.arrow_right,
                            color: AppColors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(
                      horizontal: Get.width * 0.1,
                      vertical: Get.height * 0.006),
                ],
              ),
      ),
    );
  }

  // Build table columns
  List<DataColumn> _buildTableColumns(UserManagementController controller) {
    return [
      DataColumn(
        label: Expanded(
          child: Text(
            'No.',
            style: controller.tableHeaderStyle(),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'Name',
            style: controller.tableHeaderStyle(),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'Email',
            style: controller.tableHeaderStyle(),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'Subscription',
            style: controller.tableHeaderStyle(),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'Chapter - Module',
            style: controller.tableHeaderStyle(),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'Created',
            style: controller.tableHeaderStyle(),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'Actions',
            style: controller.tableHeaderStyle(),
          ),
        ),
      ),
    ];
  }

  // Build table rows
  List<DataRow> _buildTableRows(UserManagementController controller) {
    if (controller.filteredUsers.isNotEmpty) {
      return controller.filteredUsers.map((user) {
        return DataRow(
          cells: [
            DataCell(
              Text(
                user.id.toString(),
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                user.name ?? "NA",
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                user.email ?? "NA",
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                user.currentSubscription == false ? 'No' : 'Yes',
                style: TextStyle(
                  color: user.currentSubscription == false
                      ? Colors.red
                      : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
            DataCell(
              Text(
                "${user.createdAt.toDateTime().day}/${user.createdAt.toDateTime().month}/${user.createdAt.toDateTime().year}",
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                "CH-${user.currentChapter},M-${user.currentModule}",
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.userData = {
                        'name': user.name,
                        'id': user.id,
                        /*'profilePicUrl':
                            user?.profilePic ?? "",*/
                        // Replace with actual image URL
                        'createdOn': DateFormat('dd MMMM yyyy')
                            .format(user.createdAt.toDateTime()),
                        'lastActiveDate': DateFormat('dd MMMM yyyy')
                            .format(user.lastActiveAt.toDateTime()),
                        'deviceType': user.deviceType,
                        'loginType': user.email,
                        'country': user.country,
                        'onboardCompleted': true,
                        'subscription': (user.currentSubscription),
                        'chapterAccess': user.chapterAccess,
                        'subscriptionName': 'Basic',
                        'subscriptionPrice': '399',
                        'subscriptionExpiryDate': '24 June 2024',
                        'renewalDate': '24 June 2024',
                      };
                      controller.showStatisticsDialog();
                    },
                    child: SvgPicture.asset(
                      AppIcons.analytics,
                      width: 13.sp,
                      height: 13.sp,
                    ),
                  ),
                  SizedBox(width: 1.w),
                  SvgPicture.asset(
                    AppIcons.deleteIcon,
                    width: 13.sp,
                    height: 13.sp,
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList();
    } else {
      return controller.users.map((user) {
        return DataRow(
          cells: [
            DataCell(
              Text(
                user.id.toString(),
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                user.name ?? "NA",
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                user.email ?? "NA",
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                user.currentSubscription == false ? 'No' : 'Yes',
                style: TextStyle(
                  color: user.currentSubscription == false
                      ? Colors.red
                      : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
            DataCell(
              Text(
                "CH-${user.currentChapter},M-${user.currentModule}",
                // "Pending",
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                "${user.createdAt.toDateTime().day}/${user.createdAt.toDateTime().month}/${user.createdAt.toDateTime().year}",
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.userData = {
                        'name': user.name,
                        'id': user.id,
                        /*'profilePicUrl':
                            user.profilePic, */ // Replace with actual image URL
                        'createdOn': DateFormat('dd MMMM yyyy')
                            .format(user.createdAt.toDateTime()),
                        'lastActiveDate': DateFormat('dd MMMM yyyy')
                            .format(user.lastActiveAt.toDateTime()),
                        'deviceType': user.deviceType,
                        'loginType': user.email,
                        'country': user.country,
                        'onboardCompleted': true,
                        'subscription': (user.currentSubscription),
                        'chapterAccess': user.chapterAccess,
                        'subscriptionName': 'Basic',
                        'subscriptionPrice': '399',
                        'subscriptionExpiryDate': '24 June 2024',
                        'renewalDate': '24 June 2024',
                      };

                      print(controller.userData);
                      controller.showStatisticsDialog();
                    },
                    child: SvgPicture.asset(
                      AppIcons.analytics,
                      width: 13.sp,
                      height: 13.sp,
                    ),
                  ),
                  SizedBox(width: 1.w),
                  InkWell(
                    onTap: () async {
                      AwesomeDialog(
                        width: Get.width / 3,
                        context: Get.context!,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: 'are you sure you want to delete?',
                        desc: '',
                        btnOkOnPress: () async {
                          controller.onUserDelete(
                              userId: (user.id ?? 0).toInt());
                          // await apiCall.postAPICall(
                          //     url: APIConstant.deleteUser,
                          //     data: {
                          //       "id": user.id
                          //     },
                          //     header: {
                          //       "Authorization": "Bearer ${userModel?.token}"
                          //     }).then(
                          //   (value) {
                          //     controller.fetchUsers();
                          //   },
                          // );
                        },
                        btnCancelOnPress: () {},
                      ).show();
                    },
                    child: SvgPicture.asset(
                      AppIcons.deleteIcon,
                      width: 13.sp,
                      height: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList();
    }
  }
}
