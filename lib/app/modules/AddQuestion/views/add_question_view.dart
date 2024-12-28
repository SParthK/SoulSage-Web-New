import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../data/components/app_color.dart';
import '../../../data/components/app_icons_path.dart';
import '../controllers/add_question_controller.dart';
import '../question_analysis/question_analysis_popup.dart';

class AddQuestionView extends GetView<AddQuestionController> {
  AddQuestionView({super.key});

  AddQuestionController addQuestionController =
      Get.put(AddQuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AddQuestionController>(
        builder: (controller) {
          // Check if users list is empty to display loading or no data
          return Container(
            width: MediaQuery.of(context).size.width,
            color: AppColors.appWhite,
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Add Chapter Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Question',
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.showAddQuestionDialog(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF5A00FF),
                              Color(0xFF9F00FF),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Text(
                          "+ Add Question",
                          style:
                              TextStyle(color: Colors.white, fontSize: 11.sp),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                // User Data Table
                Obx(
                  () => controller.questionList.isNotEmpty
                      ? Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth:
                                    MediaQuery.of(context).size.width / 1.5,
                              ),
                              child: DataTable(
                                columns: _buildTableColumns(controller),
                                rows: _buildTableRows(controller, context),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // Build table columns
  List<DataColumn> _buildTableColumns(AddQuestionController controller) {
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
            'Question',
            style: controller.tableHeaderStyle(),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'Edit',
            style: controller.tableHeaderStyle(),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'Delete',
            style: controller.tableHeaderStyle(),
          ),
        ),
      ),
      DataColumn(
        label: Expanded(
          child: Text(
            'analysis',
            style: controller.tableHeaderStyle(),
          ),
        ),
      ),
    ];
  }

  // Build table rows
  List<DataRow> _buildTableRows(
      AddQuestionController controller, BuildContext context) {
    if (controller.filteredQuestionList.isNotEmpty) {
      return controller.filteredQuestionList.map((question) {
        return DataRow(
          cells: [
            DataCell(
              Text(
                "${question['index']!}.",
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                question['question']!,
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              InkWell(
                onTap: () {
                  controller.showEditQuestionDialog(
                      context,
                      question['mcq'],
                      question["isMultiAns"],
                      question["question"],
                      question["questionId"]);
                },
                child: SvgPicture.asset(
                  AppIcons.editIcon,
                  width: 13.sp,
                  height: 13.sp,
                ),
              ),
            ),
            DataCell(
              InkWell(
                onTap: () {
                  AwesomeDialog(
                    width: Get.width / 3,
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.rightSlide,
                    title: 'are you sure you want to delete.',
                    desc: '',
                    btnCancelOnPress: () {},
                    btnOkOnPress: () {
                      controller.deleteQuestion(question["questionId"]);
                    },
                  )..show();
                },
                child: SvgPicture.asset(
                  AppIcons.deleteIcon,
                  width: 13.sp,
                  height: 13.sp,
                ),
              ),
            ),
            DataCell(
              InkWell(
                onTap: () {
                  controller.fetchQuestionAnalysis(question["questionId"]).then(
                    (value) {
                      Get.defaultDialog(
                          title: "",
                          content: QuestionAnalysis(
                            questionId: controller.analysisData.isEmpty
                                ? 0
                                : controller.analysisData.first["id"],
                            totalUser: controller.analysisData.isEmpty
                                ? 0
                                : controller.analysisData.first["totalUser"],
                          ),
                          backgroundColor: AppColors.appWhite);
                    },
                  );
                },
                child: SvgPicture.asset(
                  AppIcons.analytics,
                  width: 13.sp,
                  height: 13.sp,
                ),
              ),
            ),
          ],
        );
      }).toList();
    } else {
      return controller.questionList.map((question) {
        return DataRow(
          cells: [
            DataCell(
              Text(
                "${question['index']!}.",
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              Text(
                question['question']!,
                style: controller.tableBodyStyle(),
              ),
            ),
            DataCell(
              InkWell(
                onTap: () {
                  controller.showEditQuestionDialog(
                      context,
                      question['mcq'],
                      question["isMultiAns"],
                      question["question"],
                      question["questionId"]);
                },
                child: SvgPicture.asset(
                  AppIcons.editIcon,
                  width: 13.sp,
                  height: 13.sp,
                ),
              ),
            ),
            DataCell(
              InkWell(
                onTap: () {
                  controller.deleteQuestion(question["questionId"]);
                },
                child: SvgPicture.asset(
                  AppIcons.deleteIcon,
                  width: 13.sp,
                  height: 13.sp,
                ),
              ),
            ),
            DataCell(
              InkWell(
                onTap: () {
                  controller.fetchQuestionAnalysis(question["questionId"]).then(
                    (value) {
                      Get.defaultDialog(
                          title: "",
                          content: QuestionAnalysis(
                            questionId: controller.analysisData.isEmpty
                                ? 0
                                : controller.analysisData.first["id"],
                            totalUser: controller.analysisData.isEmpty
                                ? 0
                                : controller.analysisData.first["totalUser"],
                          ),
                          backgroundColor: AppColors.appWhite);
                    },
                  );
                },
                child: SvgPicture.asset(
                  AppIcons.analytics,
                  width: 13.sp,
                  height: 13.sp,
                ),
              ),
            ),
          ],
        );
      }).toList();
    }
  }
}
