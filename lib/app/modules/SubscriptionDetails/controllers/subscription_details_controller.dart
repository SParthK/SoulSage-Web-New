import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SubscriptionDetailsController extends GetxController {
  var subscriptionList = <Map<String, dynamic>>[].obs;

  // Controllers for Add and Edit subscriptions
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchSubscription();
  }

  // Fetch initial subscription data
  void fetchSubscription() {
    subscriptionList.addAll([
      {
        'index': '1',
        'subscription_name': 'Gold',
        'subscription_price': 'INR 450',
        'subscription_duration': '3 Months',
      },
      {
        'index': '2',
        'subscription_name': 'Silver',
        'subscription_price': 'INR 850',
        'subscription_duration': '6 Months',
      },
    ]);
  }

  // Add a new subscription
  void addSubscription() {
    if (nameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        durationController.text.isNotEmpty) {
      int newIndex = subscriptionList.length + 1;
      subscriptionList.add({
        'index': newIndex.toString(),
        'subscription_name': nameController.text,
        'subscription_price': priceController.text,
        'subscription_duration': durationController.text,
      });
      clearControllers();
    }
  }

  // Edit an existing subscription
  void editSubscription(int index) {
    subscriptionList[index] = {
      'index': (index + 1).toString(),
      'subscription_name': nameController.text,
      'subscription_price': priceController.text,
      'subscription_duration': durationController.text,
    };
    clearControllers();
  }

  // Delete subscription
  void deleteSubscription(int index) {
    subscriptionList.removeAt(index);
  }

  // Clear input controllers after use
  void clearControllers() {
    nameController.clear();
    priceController.clear();
    durationController.clear();
  }

  // Open the Add Subscription Dialog
  void showAddSubscriptionDialog() {
    Get.defaultDialog(
      title: 'Add Subscription',
      contentPadding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 2.w),
      titleStyle: TextStyle(
        color: Colors.black,
        fontSize: 12.sp,
      ),
      titlePadding: EdgeInsets.only(top: 5.h),
      content: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              height: 40,
              width: 20.w,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Subscription Name',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red.withOpacity(0.5), width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              height: 40,
              width: 20.w,
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(
                  hintText: 'Subscription Price',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red.withOpacity(0.5), width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              height: 40,
              width: 20.w,
              child: TextField(
                controller: durationController,
                decoration: InputDecoration(
                  hintText: 'Duration (e.g., 3 Months)',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red.withOpacity(0.5), width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ),
            ),
          ),
          ],
      ),
      textConfirm: 'Add',
      textCancel: 'Cancel',
      onConfirm: () {
        addSubscription();
        Get.back();
      },
    );
  }

  // Open the Edit Subscription Dialog
  void showEditSubscriptionDialog(int index) {
    var subscription = subscriptionList[index];
    nameController.text = subscription['subscription_name'];
    priceController.text = subscription['subscription_price'];
    durationController.text = subscription['subscription_duration'];

    Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 2.w),
      titleStyle: TextStyle(
        color: Colors.black,
        fontSize: 12.sp,
      ),
      titlePadding: EdgeInsets.only(top: 5.h),
      title: 'Edit Subscription',
      content: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              height: 40,
              width: 20.w,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Subscription Name',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red.withOpacity(0.5), width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              height: 40,
              width: 20.w,
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(
                  hintText: 'Subscription Price',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red.withOpacity(0.5), width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              height: 40,
              width: 20.w,
              child: TextField(
                controller: durationController,
                decoration: InputDecoration(
                  hintText: 'Duration (e.g., 3 Months)',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red.withOpacity(0.5), width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ),
            ),
          ),
        ],
      ),
      textConfirm: 'Save',
      textCancel: 'Cancel',
      onConfirm: () {
        editSubscription(index);
        Get.back();
      },
    );
  }
}
