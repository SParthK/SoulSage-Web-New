import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:sizer/sizer.dart';
import 'package:soul_sage_web/app/data/api_service/config.dart';
import 'package:soul_sage_web/app/data/components/app_color.dart';
import 'package:soul_sage_web/app/data/components/constants.dart';
import 'package:soul_sage_web/app/data/get_storage/get_storage.dart';
import 'package:soul_sage_web/app/data/repository/user_mange_repository.dart';

import '../../../../utils/app_utils.dart';

import '../../../data/model/response/user_response.dart';
import '../views/user_details_pop_up.dart';

class UserManagementController extends GetxController {
  // Ensure this is initialized to avoid null issues
  final UserMangeRepository _userMangeRepository = UserMangeRepository();

  // List<User> users = <User>[].obs;
  // List<User> filteredUsers = <User>[].obs;
  RxBool isLoading = false.obs;
  RxBool isMaxScrolled = false.obs;
  RxList<UserList> users = <UserList>[].obs;
  RxList<UserList> filteredUsers =
      <UserList>[].obs; // For storing filtered results
  RxString searchQuery = ''.obs;
  final TextEditingController exactDateController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  RxBool isSubscribed = false.obs; // For zsubscription filter
  RxBool isFilterTrue = false.obs; // For subscription filter
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RxInt userListPageNumber = 1.obs;
  RxInt userListMaxPageNumber = 0.obs;
  Map<String, dynamic> userData = {};

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUserList();
  }

  // Function to trigger the popup
  void showStatisticsDialog() {
    Get.defaultDialog(
      title: "",
      content: UserStatisticsPopup(),
    );
  }

  onAddUserSubscription(
      {required String name,
      required int userId,
      required int durationInDay}) async {
    await EasyLoading.show();
    try {
      final response = await _userMangeRepository.userSubscription(userData: {
        "name": name,
        "user_id": userId,
        "price": "0",
        "duration": durationInDay
      });
      if (response.data?.success == true) {
        Get.back();
        await getUserList();
      } else {
        AppUtils.showToast(msg: response.data?.message ?? "");
      }
    } catch (e) {
      AppUtils.showToast(msg: "Something went wrong.");
    } finally {
      await EasyLoading.dismiss();
    }
  }

  onChangeChapterAccessTime({required int userId}) async {
    await EasyLoading.show();
    try {
      final response =
          await _userMangeRepository.unlockChapterTimer(userId: userId);
      if (response.data?.success == true) {
        Get.back();
        await getUserList();
      } else {
        AppUtils.showToast(msg: response.data?.message ?? "");
      }
    } catch (e) {
      AppUtils.showToast(msg: "Something went wrong.");
    } finally {
      await EasyLoading.dismiss();
    }
  }

  onUserDelete({required int userId}) async {
    await EasyLoading.show();
    try {
      final response = await _userMangeRepository.deleteUser(userId: userId);
      if (response.data?.success == true) {
        await getUserList();
      } else {
        AppUtils.showToast(msg: response.data?.message ?? "");
      }
    } catch (e) {
      AppUtils.showToast(msg: "Something went wrong.");
    } finally {
      await EasyLoading.dismiss();
    }
  }

  getUserList() async {
    users.clear();
    isLoading.value = true;
    await EasyLoading.show();
    try {
      final response = await _userMangeRepository.getUserList(
        pageNo: userListPageNumber.value,
      );
      if (response.data?.success == true && response.data?.data != null) {
        UserResponse userList = UserResponse.fromJson(response.data?.data);
        users.value = userList.userList ?? <UserList>[];
        userListMaxPageNumber.value =
            int.parse("${userList.metaData?.totalPage ?? 0}");
        userListPageNumber.value = int.parse("${userList.metaData?.page ?? 0}");
      } else {
        AppUtils.showToast(msg: response.data?.message ?? '');
      }
    } catch (e) {
      print("ERROR on getVehicleInspectionList ${e}");
      // AppUtils.showToast(msg: 'Something went Wrong...');
    } finally {
      isLoading.value = false;
      users.refresh();
      update();
      await EasyLoading.dismiss();
    }
  }

  // getOtherPageUserList() async {
  //   await Future.delayed(Duration(milliseconds: 100));
  //   if (userListPageNumber.value <=
  //       userListMaxPageNumber.value &&
  //       userListPageNumber.value != 1) {
  //     isMaxScrolled.value = true;
  //     try {
  //       final response = await _userMangeRepository.getUserList(
  //         pageNo: userListPageNumber.value,
  //       );
  //       if (response.data?.success == true && response.data?.data != null) {
  //         UserResponse userList = UserResponse.fromJson(response.data?.data);
  //         users.value = userList.userList ?? <UserList>[];
  //         userListMaxPageNumber.value =
  //             int.parse("${userList.metaData?.totalPage ?? 0}");
  //         if (userListMaxPageNumber.value >= userListPageNumber.value) {
  //           log("message---3--[[] ${userListPageNumber.value}");
  //           userListPageNumber.value++;
  //         }
  //       } else {
  //         AppUtils.showToast(msg: response.data?.message ?? '');
  //       }
  //     } catch (e) {
  //       print("ERROR on getVehicleInspectionList ${e}");
  //       // AppUtils.showToast(msg: 'Something went Wrong...');
  //     } finally {
  //       isMaxScrolled.value = false;
  //     }
  //   }
  // }

  // Fetch or set user data
  // fetchUsers() async {
  //   try {
  //     isLoading.value = true;
  //     await EasyLoading.show();
  //     final response = await _userMangeRepository.getUserList();
  //     if (response.data?.success == true && response.data?.data != null) {
  //       UserResponse userList = UserResponse.fromJson(response.data?.data);
  //       // List<UserResponse> userList = [];
  //       // for (var i = 0; i < (response.data?.data).length; i++) {
  //       //   userList.add(UserResponse.fromJson(response.data?.data[i]));
  //       // }
  //       users.value = userList.userList ?? <UserList>[];
  //     } else {
  //       AppUtils.showToast(msg: response.data?.message ?? '');
  //     }
  //   } catch (e) {
  //     log("message-=----$e");
  //   } finally {
  //     isLoading.value = false;
  //     users.refresh();
  //     update();
  //     await EasyLoading.dismiss();
  //   }
  // }

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
      filteredUsers.value = users
          .where((user) =>
              (user.email ?? "").toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    }
    filteredUsers.refresh();
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

    filteredUsers.value = users.where((user) {
      // Check the exact date filter
      bool matchesExactDate = exactFilterDate == null ||
          (user.createdAt.toDateTime().year == exactFilterDate.year &&
              user.createdAt.toDateTime().month == exactFilterDate.month &&
              user.createdAt.toDateTime().day == exactFilterDate.day);

      // Check the subscription filter, if provided
      bool matchesSubscription = hasSubscription == null ||
          (hasSubscription
              ? user.currentSubscription != false
              : user.currentSubscription == false);

      // Check the date range filter
      bool matchesDateRange = (startFilterDate == null ||
              user.createdAt.toDateTime().isAfter(startFilterDate)) &&
          (endFilterDate == null ||
              user.createdAt.toDateTime().isBefore(endFilterDate));

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
