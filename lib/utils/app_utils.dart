import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../app/data/components/app_color.dart';
import '../app/data/model/dto/response.dart';
import '../app/data/model/response/generic_response.dart';

class AppUtils {
  AppUtils._privateConstructor();

  static getSnackBar() {
    return Get.showSnackbar(
      GetSnackBar(
        backgroundColor: Colors.white,
        borderRadius: 12,
        // boxShadows: [AppColors.commonBoxShadow],
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        messageText: Text("asoinasod sdas"),
        duration: Duration(seconds: 2),
        title: "Trsting",
        snackPosition: SnackPosition.BOTTOM,
      ),
    );
  }

  static getAddItemSnackBar() {
    return Get.rawSnackbar(
        titleText: Row(
      children: [
        Icon(
          Icons.check_circle,
          // color: AppColors.blueButtonColor,
        ),
        Text("")
      ],
    ));
  }

  static getBottomSheet({
    required List<Widget> children,
    bool? isDismissible,
    EdgeInsets? padding,
    bool? enableDrag,
  }) =>
      Get.bottomSheet(
        GestureDetector(
          onTap: isDismissible ?? true ? () => Get.back() : () {},
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: padding ??
                const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
            children: children,
          ),
        ),
        enableDrag: enableDrag ?? true,
        isDismissible: isDismissible ?? true,
        backgroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        isScrollControlled: true,
        ignoreSafeArea: false,
      );

  static Future<bool?> showErrorMsg(
      {required RepoResponse<GenericResponse> response}) {
    // Fluttertoast.cancel();
    if ((response.data?.message ??
            response.error?.message ??
            'Something went wrong. Please try again later.') ==
        "Data not found") {
      return Future<bool>.value(false);
    }
    return Fluttertoast.showToast(
        msg: response.data?.message ??
            response.error?.message ??
            'Something went wrong. Please try again later.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.white,
        textColor: AppColors.black,
        fontSize: 16.0);
  }

  static Future<bool?> showToast({required String msg}) {
    // Fluttertoast.cancel();
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.white,
        textColor: AppColors.black,
        fontSize: 16.0);
  }
}

extension StringToDateTime on String? {
  DateTime toDateTime() {
    if (this == null || this!.trim().isEmpty) {
      return DateTime.now();
    }
    try {
      return DateTime.parse(this!);
    } catch (e) {
      throw FormatException("Invalid date format: $this");
    }
  }
}
