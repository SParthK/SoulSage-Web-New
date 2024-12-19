import 'package:awesome_dialog/awesome_dialog.dart';
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

import '../controllers/user_management_controller.dart';

class UserManagementView extends GetView<UserManagementController> {
  UserManagementView({super.key});

  UserManagementController userManagementController =
      Get.put(UserManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserManagementController>(
        builder: (controller) {
          // Check if users list is empty to display loading or no data
          if (controller.users.isEmpty) {
            return Center(
              child: Text(
                "No Users found",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 2.h,
                ),
              ),
            );
          }

          return Container(
            width: MediaQuery.of(context).size.width,
            color: AppColors.appWhite,
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      'Total User : ${userManagementController.filteredUsers.isEmpty ? userManagementController.users.length : userManagementController.filteredUsers.length}',
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
                        minWidth: MediaQuery.of(context).size.width / 1.5,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: _buildTableColumns(controller),
                          rows: _buildTableRows(controller),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
                user.name,
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                user.email,
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                user.currentSubscription == 0 ? 'No' : 'Yes',
                style: TextStyle(
                  color:
                      user.currentSubscription == 0 ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
            DataCell(
              Text(
                "${user.createdAt.day}/${user.createdAt.month}/${user.createdAt.year}",
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                "CH-${user.maxChapter},M-${user.maxModule}",
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
                        'profilePicUrl':
                            user.profilePic, // Replace with actual image URL
                        'createdOn':
                            DateFormat('dd MMMM yyyy').format(user.createdAt),
                        'lastActiveDate': DateFormat('dd MMMM yyyy')
                            .format(user.lastActiveAt ?? DateTime.now()),
                        'deviceType': user.deviceType,
                        'loginType': user.email,
                        'country': user.country,
                        'onboardCompleted': true,
                        'subscription':
                            (user.currentSubscription == 0 ? false : true),
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
                user.name,
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                user.email,
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                user.currentSubscription == 0 ? 'No' : 'Yes',
                style: TextStyle(
                  color:
                      user.currentSubscription == 0 ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
            DataCell(
              Text(
                "CH-${user.maxChapter},M-${user.maxModule}",
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                "${user.createdAt.day}/${user.createdAt.month}/${user.createdAt.year}",
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
                        'profilePicUrl':
                            user.profilePic, // Replace with actual image URL
                        'createdOn':
                            DateFormat('dd MMMM yyyy').format(user.createdAt),
                        'lastActiveDate': DateFormat('dd MMMM yyyy')
                            .format(user.lastActiveAt),
                        'deviceType': user.deviceType,
                        'loginType': user.email,
                        'country': user.country,
                        'onboardCompleted': true,
                        'subscription':
                            (user.currentSubscription == 0 ? false : true),
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
                          await apiCall.postAPICall(
                              url: APIConstant.deleteUser,
                              data: {
                                "id": user.id
                              },
                              header: {
                                "Authorization": "Bearer ${userModel?.token}"
                              }).then(
                            (value) {
                              controller.fetchUsers();
                            },
                          );
                        },
                        btnCancelOnPress: () {},
                      )..show();
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
