// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:soul_sage_web/app/data/components/app_color.dart';
//
// import '../controllers/add_question_controller.dart';
//
// class Questionanalysis extends GetView<AddQuestionController> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(builder: (AddQuestionController addQuestionController) {
//       return Container(
//         width: 70.w,
//         height: 40.h,
//         color: AppColors.appWhite,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Title of the Popup
//             Text(
//               'Analysis',
//               style: TextStyle(
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 2.h),
//             // Circular Indicators
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: addQuestionController.analysisData.map((data) {
//                   log("message-=----=-- ${data}");
//                   return _buildCircularIndicator(
//                       data['label'].toString(),
//                       double.parse(data['percentage'].toString()),
//                       data['description'].toString());
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   // Build the circular indicators for each option
//   Widget _buildCircularIndicator(
//       String label, double percentage, String description) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         CircularPercentIndicator(
//           radius: 5.h,
//           lineWidth: 0.5.w,
//           percent: percentage / 100,
//           center: Text(
//             '$percentage%',
//             style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
//           ),
//           progressColor: const Color(0xFF5A00FF),
//           backgroundColor: Colors.grey.shade200,
//           circularStrokeCap: CircularStrokeCap.round,
//         ),
//         SizedBox(height: 1.h),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12.sp,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF5A00FF),
//           ),
//         ),
//         SizedBox(height: 0.5.h),
//         Text(
//           "Total User - $description",
//           style: TextStyle(fontSize: 12.sp, color: AppColors.appColor),
//         ),
//       ],
//     );
//   }
// }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:soul_sage_web/app/data/components/app_color.dart';

import '../controllers/add_question_controller.dart';

class QuestionAnalysis extends GetView<AddQuestionController> {
  final int totalUser;
  final int questionId;

  const QuestionAnalysis(
      {super.key, required this.totalUser, required this.questionId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddQuestionController>(
      builder: (addQuestionController) {
        return Container(
          width: 70.w,
          height: 40.h,
          color: AppColors.appWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title of the Popup
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Analysis',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Total User - $totalUser",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              // Responsive GridView for Circular Indicators
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _calculateCrossAxisCount(context),
                    crossAxisSpacing: 3.w,
                    // mainAxisSpacing: 3.h,
                    childAspectRatio: 1, // Adjust this for content scaling
                  ),
                  itemCount: addQuestionController.analysisData.length,
                  itemBuilder: (context, index) {
                    final data = addQuestionController.analysisData[index];
                    log("Data: $data");
                    return _buildCircularIndicator(
                        data['label'].toString(),
                        double.parse(data['percentage'].toString()),
                        data['description'].toString(),
                        data['id']);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Calculate cross-axis count based on screen size
  int _calculateCrossAxisCount(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 1200) {
      return 4;
    } else if (screenWidth > 800) {
      return 3;
    } else {
      return 2;
    }
  }

  // Build the circular indicators for each option
  Widget _buildCircularIndicator(
      String label, double percentage, String description, int questionId) {
    return GestureDetector(
      onTap: () {
        controller.getQuestionAnsWithUser(
            questionId: questionId, mcqKey: label);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularPercentIndicator(
            radius: 7.h,
            lineWidth: 0.7.w,
            percent: percentage / 100,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$percentage%',
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5A00FF),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            progressColor: const Color(0xFF5A00FF),
            backgroundColor: Colors.grey.shade200,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          SizedBox(height: 0.5.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.appColor,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
