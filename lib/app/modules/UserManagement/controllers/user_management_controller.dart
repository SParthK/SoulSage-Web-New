import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:soul_sage_web/app/data/api_service/config.dart';
import 'package:soul_sage_web/app/data/components/app_color.dart';
import 'package:soul_sage_web/app/data/components/constants.dart';

import '../../../data/api_response_model/user_list_model.dart';
import '../views/user_details_pop_up.dart';

class UserManagementController extends GetxController {
  // Ensure this is initialized to avoid null issues
  List<User> users = <User>[].obs;
  List<User> filteredUsers = <User>[].obs; // For storing filtered results
  RxString searchQuery = ''.obs;
  final TextEditingController exactDateController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  RxBool isSubscribed = false.obs; // For zsubscription filter
  RxBool isFilterTrue = false.obs; // For subscription filter

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Map<String, dynamic> userData = {};

  // Function to trigger the popup
  void showStatisticsDialog() {
    Get.defaultDialog(
      title: "",
      content: UserStatisticsPopup(),
    );
  }

  // Fetch or set user data
  void fetchUsers() {
    apiCall.getAPICall(APIConstant.userList,
        header: {"Authorization": "Bearer ${userModel?.token}"}).then(
      (value) {
        print("value.data");
        UserList userList = UserList.fromJson(value.data);
        users = userList.users;
        update();
      },
    );
  }

  // Table header text style
  TextStyle tableHeaderStyle() {
    return GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: 12.sp,
      color: AppColors.textColor,
    );
  }

  // Table body text style
  TextStyle tableBodyStyle() {
    return GoogleFonts.poppins(
      fontSize: 11.sp,
      color: Colors.black,
    );
  }

  void filterUsersByEmail(String query) {
    if (query.isEmpty) {
      filteredUsers = users; // Show all users when search is empty
    } else {
      filteredUsers = users
          .where(
              (user) => user.email.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update(); // Refresh the UI with filtered results
  }

  void filterUsers(String exactDate, bool? hasSubscription, String startDate,
      String endDate) {
    DateTime? exactFilterDate =
        exactDate.isNotEmpty ? DateTime.tryParse(exactDate) : null;
    DateTime? startFilterDate =
        startDate.isNotEmpty ? DateTime.tryParse(startDate) : null;
    DateTime? endFilterDate =
        endDate.isNotEmpty ? DateTime.tryParse(endDate) : null;

    filteredUsers = users.where((user) {
      // Check the exact date filter
      bool matchesExactDate = exactFilterDate == null ||
          (user.createdAt.year == exactFilterDate.year &&
              user.createdAt.month == exactFilterDate.month &&
              user.createdAt.day == exactFilterDate.day);

      // Check the subscription filter, if provided
      bool matchesSubscription = hasSubscription == null ||
          (hasSubscription
              ? user.currentSubscription != 0
              : user.currentSubscription == 0);

      // Check the date range filter
      bool matchesDateRange = (startFilterDate == null ||
              user.createdAt.isAfter(startFilterDate)) &&
          (endFilterDate == null || user.createdAt.isBefore(endFilterDate));

      // Combine all filters
      return matchesExactDate && matchesSubscription && matchesDateRange;
    }).toList();

    update(); // Refresh UI
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Filter Users"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Filter by Exact Date Added
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: exactDateController,
                    decoration: const InputDecoration(
                      labelText: 'Date Added (yyyy-mm-dd)',
                      suffixIcon: Icon(Icons.calendar_today),
                      border: InputBorder.none, // Remove default border
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        exactDateController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // Filter by Subscription Status
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Obx(
                    () => CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text("Has Subscription"),
                      value: isSubscribed.value,
                      onChanged: (bool? value) {
                        isSubscribed.value = value ?? false;
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Filter by Start Date
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: startDateController,
                    decoration: const InputDecoration(
                      labelText: 'Start Date (yyyy-mm-dd)',
                      suffixIcon: Icon(Icons.calendar_today),
                      border: InputBorder.none,
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        startDateController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // Filter by End Date
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: endDateController,
                    decoration: const InputDecoration(
                      labelText: 'End Date (yyyy-mm-dd)',
                      suffixIcon: Icon(Icons.calendar_today),
                      border: InputBorder.none,
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        endDateController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Reset the filter fields on Cancel
                _resetFilterFields();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Call your filter function with values
                filterUsers(
                  exactDateController.text,
                  isSubscribed.value,
                  startDateController.text,
                  endDateController.text,
                );
                _resetFilterFields(); // Reset fields after applying filter
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Apply Filters"),
            ),
          ],
        );
      },
    );
  }

// Method to reset all filter fields
  void _resetFilterFields() {
    exactDateController.clear();
    startDateController.clear();
    endDateController.clear();
    isSubscribed.value = false;
  }
}
