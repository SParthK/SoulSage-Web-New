import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:soul_sage_web/app/data/api_service/config.dart';
import 'package:soul_sage_web/app/data/components/constants.dart';
import 'package:soul_sage_web/app/modules/UserManagement/controllers/user_management_controller.dart';
import 'package:soul_sage_web/utils/app_color.dart';
import 'package:soul_sage_web/utils/dimens.dart';

class UserStatisticsPopup extends GetView<UserManagementController> {
  @override
  Widget build(BuildContext context) {
    final user = controller.userData;
    log("message-=---- ${user["subscription"]}");

    return GetBuilder(
        builder: (UserManagementController userManagementController) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Statistics',
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (user["subscription"] != true)
                  ElevatedButton(
                    onPressed: () async {
                      DateTime today = DateTime.now();
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: today,
                        firstDate: today,
                        lastDate: DateTime(
                            today.year + 5), // Limit to 5 years in the future
                      );

                      if (pickedDate != null) {
                        int dayCount = pickedDate.difference(today).inDays;
                        controller.onAddUserSubscription(
                          userId: user["id"],
                          name: user["name"],
                          durationInDay: dayCount,
                        );
                      } else {
                        EasyLoading.showToast("Please future date.");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A00FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                    ),
                    child: Text(
                      'Unlock subscription',
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                if (user["chapterAccess"] == false)
                  ElevatedButton(
                    onPressed: () async {
                      await controller.onChangeChapterAccessTime(
                          userId: user["id"]);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A00FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                    ),
                    child: Text(
                      'Unlock Timer',
                      style: GoogleFonts.poppins(
                        fontSize: 10.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 2.h),
            // Profile picture and name
            /*Row(
              children: [
                CircleAvatar(
                  radius: 20.sp,
                  backgroundImage:
                      NetworkImage(user['profilePicUrl'].toString()),
                ),
                SizedBox(width: 2.w),
                Text(
                  user['name'].toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),*/
            Text(
              user['name'].toString(),
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: AppColors.appPrimaryColorPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h),
            // Data details
            _buildUserDetails(user),
          ],
        ),
      );
    });
  }

  // Function to create user details layout
  Widget _buildUserDetails(Map<String, dynamic> user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Created on', user['createdOn'], 'Subscription',
            user['subscription'] ? 'Yes' : 'No'),
        _buildInfoRow('Last active date', user['lastActiveDate'],
            'Subscription Name', user['subscriptionName']),
        _buildInfoRow('Device type', user['deviceType'], 'Subscription Price',
            user['subscriptionPrice']),
        _buildInfoRow('Login Type', user['loginType'],
            'Subscription Expiry date', user['subscriptionExpiryDate'],
            highlightRight: true),
        _buildInfoRow(
            'Country', user['country'], 'Renewal Date', user['renewalDate']),
        _buildInfoRow('Onboard Completed',
            user['onboardCompleted'] ? 'Yes' : 'No', '', ""),
      ],
    );
  }

  // Reusable function to build two-column information rows
  Widget _buildInfoRow(
      String leftLabel, String leftValue, String rightLabel, String rightValue,
      {bool highlightRight = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  '$leftLabel: ',
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  leftValue,
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Dimens.widthGap10,
          Expanded(
            child: Row(
              children: [
                if (rightLabel.isNotEmpty)
                  Text(
                    '$rightLabel: ',
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (rightValue.isNotEmpty)
                  Text(
                    rightValue,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: highlightRight ? Colors.red : Colors.black,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
