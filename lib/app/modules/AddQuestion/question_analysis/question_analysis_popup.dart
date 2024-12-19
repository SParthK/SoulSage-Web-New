import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:soul_sage_web/app/data/components/app_color.dart';

import '../controllers/add_question_controller.dart';

class Questionanalysis extends GetView<AddQuestionController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (AddQuestionController addQuestionController) {
      return Container(
        width: 70.w,
        height: 40.h,
        color: AppColors.appWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title of the Popup
            Text(
              'Analysis',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            // Circular Indicators
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: addQuestionController.analysisData.map((data) {
                  return _buildCircularIndicator(
                      data['label'].toString(),
                      double.parse(data['percentage'].toString()),
                      data['description'].toString());
                }).toList(),
              ),
            ),
          ],
        ),
      );
    });
  }

  // Build the circular indicators for each option
  Widget _buildCircularIndicator(
      String label, double percentage, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularPercentIndicator(
          radius: 5.h,
          lineWidth: 0.5.w,
          percent: percentage / 100,
          center: Text(
            '$percentage%',
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
          progressColor: const Color(0xFF5A00FF),
          backgroundColor: Colors.grey.shade200,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        SizedBox(height: 1.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5A00FF),
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          "Total User - $description",
          style: TextStyle(fontSize: 12.sp, color: AppColors.appColor),
        ),
      ],
    );
  }
}
