import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:soul_sage_web/app/data/api_service/config.dart';
import 'package:soul_sage_web/app/data/components/constants.dart';

import '../../../data/api_response_model/question_model.dart';
import '../../../data/api_service/models/questions_analytics_model.dart';
import '../../../data/components/app_color.dart';

class AddQuestionController extends GetxController {
  var questionList = <Map<String, dynamic>>[].obs;
  var filteredQuestionList =
      <Map<String, dynamic>>[].obs; // To store filtered data
  TextEditingController editQuestionController = TextEditingController();
  RxInt isMultiAnswer = 0.obs;

  final RxList<Map<String, dynamic>> analysisData =
      <Map<String, dynamic>>[].obs;

  var options =
      <TextEditingController>[].obs; // To store dynamic option controllers

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  // Fetch initial question data
  void fetchQuestions() {
    questionList.clear();
    apiCall.getAPICall(APIConstant.questionList,
        header: {"Authorization": "Bearer ${userModel?.token}"}).then(
      (value) {
        QuestionsModel questionsModel = QuestionsModel.fromJson(value.data);
        for (int i = 0; i < questionsModel.questions.length; i++) {
          questionList.add(
            {
              'index': i,
              'question': questionsModel.questions[i].title,
              "questionId": questionsModel.questions[i].id.toString(),
              "mcq": questionsModel.questions[i].mcqs,
              'isMultiAns': questionsModel.questions[i].multiAnswer
            },
          );
          update();
        }
      },
    );
  }

  // Filter questions based on search query
  void filterQuestionsByQuery(String query) {
    if (query.isEmpty) {
      // If the query is empty, show all questions
      filteredQuestionList.value = questionList;
    } else {
      // Filter questions that match the query (case-insensitive)
      filteredQuestionList.value = questionList
          .where((question) => question['question']!
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    update(); // Update the UI
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

  // Add a new question with dynamic options and make an API call
  void addQuestionWithOptions(String newQuestion, List<String> optionsList) {
    int questionIndex = questionList.length + 1;

    // Construct the payload to send to the API
    Map<String, dynamic> questionData = {
      "title": newQuestion,
      "mcqs": optionsList
          .asMap()
          .map((index, option) =>
              MapEntry(index, {"${String.fromCharCode(97 + index)}": option}))
          .values
          .toList(),
      "multi_answer": isMultiAnswer.value.toString(),
    };

    // Add locally first (this can be removed if not needed)
    questionList.add({
      'index': questionIndex.toString(),
      'question': newQuestion,
      'options': optionsList,
    });
    update();

    // Send API call to add the new question
    apiCall
        .postAPICall(
            url: APIConstant.addQuestion,
            header: {"Authorization": "Bearer ${userModel?.token}"},
            data: questionData)
        .then((response) {
      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar('Success', 'Question added successfully');
        fetchQuestions();
      } else {
        Get.snackbar('Error', 'Failed to add question');
      }
    });
  }

  // Add new option dynamically
  void addNewOption() {
    options.add(TextEditingController()); // Add new option controller
    update(); // Update the UI
  }

  // Add a new question with dynamic options and make an API call
  void editQuestionWithOptions(
      String newQuestion, List<String> optionsList, String questionId) {
    // Construct the payload to send to the API
    Map<String, dynamic> questionData = {
      'id': questionId,
      "title": newQuestion,
      "mcqs": optionsList
          .asMap()
          .map((index, option) =>
              MapEntry(index, {String.fromCharCode(97 + index): option}))
          .values
          .toList(),
      "multi_answer": isMultiAnswer.value.toString(),
    };

    // Send API call to add the new question
    apiCall
        .postAPICall(
            url: APIConstant.questionEditPost,
            header: {"Authorization": "Bearer ${userModel?.token}"},
            data: questionData)
        .then((response) {
      if (response.statusCode == 200) {
        Get.back();
        Get.snackbar('Success', 'Question added successfully');
        fetchQuestions();
      } else {
        Get.snackbar('Error', 'Failed to add question');
      }
    });
  }

  // Remove option at a specific index
  void removeOption(int index) {
    if (options.length > 1) {
      options.removeAt(index);
      update();
    }
  }

  // Clear all option controllers
  void clearOptions() {
    options.clear();
    options.add(TextEditingController()); // Start with one option by default
  }

  // Clear all option controllers
  void clearOptionsEdit() {
    options.clear();
  }

  // Show the "Add Question" popup
  void showAddQuestionDialog(BuildContext context) {
    final TextEditingController questionController = TextEditingController();
    clearOptions(); // Initialize with one option

    Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
      titleStyle: TextStyle(
        color: Colors.black,
        fontSize: 12.sp,
      ),
      titlePadding: EdgeInsets.only(top: 5.h),
      title: 'Add Question',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add the question',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              height: 50,
              width: 20.w,
              child: TextField(
                controller: questionController,
                decoration: InputDecoration(
                  hintText: 'Enter the question',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red.withOpacity(0.5), width: 0.5),
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

          SizedBox(height: 2.h),

          // Options Input Section
          Text(
            'Add the Options',
            style: GoogleFonts.poppins(fontSize: 12.sp),
          ),
          SizedBox(height: 2.h),

          // Dynamic list of options
          Obx(
            () => options.length <= 3
                ? Column(
                    children: List.generate(
                      options.length,
                      (index) => Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: options[index],
                              decoration: InputDecoration(
                                hintText: 'Enter option ${index + 1}',
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red.withOpacity(0.5),
                                      width: 0.5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                              ),
                            )),
                            SizedBox(width: 2.w),

                            // Remove button for each option (hide for the first option)
                            if (index > 0)
                              IconButton(
                                icon: Icon(Icons.remove_circle,
                                    color: Colors.red),
                                onPressed: () => removeOption(index),
                              ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 35.h,
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          options.length,
                          (index) => Padding(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Row(
                              children: [
                                Expanded(
                                    child: TextField(
                                  controller: options[index],
                                  decoration: InputDecoration(
                                    hintText: 'Enter option ${index + 1}',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.5),
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                  ),
                                )),
                                SizedBox(width: 2.w),

                                // Remove button for each option (hide for the first option)
                                if (index > 0)
                                  IconButton(
                                    icon: Icon(Icons.remove_circle,
                                        color: Colors.red),
                                    onPressed: () => removeOption(index),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),

          // Add new option button
          TextButton.icon(
            onPressed: addNewOption,
            icon: Icon(
              Icons.add_circle,
              color: Color(0xFF5A00FF),
            ),
            label: Text(
              'Add Option',
              style: GoogleFonts.poppins(
                  color: Color(0xFF5A00FF), fontSize: 10.sp),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GetBuilder(builder: (AddQuestionController addQuestionController) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: CheckboxListTile(
                  value: isMultiAnswer.value == 0 ? false : true,
                  title: const Text('is Multi Select'),
                  onChanged: (bool? value) {
                    isMultiAnswer.value = (value! == true ? 1 : 0);
                    update();
                  }),
            );
          }),
        ],
      ),
      textConfirm: 'Add',
      textCancel: 'Cancel',
      onConfirm: () {
        if (questionController.text.isNotEmpty && options.isNotEmpty) {
          var optionsList =
              options.map((controller) => controller.text).toList();
          addQuestionWithOptions(questionController.text, optionsList);
          Get.back();
        }
      },
    );
  }

  void showEditQuestionDialog(BuildContext context, List<Mcq> mCQS, int isMulti,
      String question, String questionID) {
    clearOptionsEdit(); // Initialize with one option

    for (var i = 0; i < mCQS.length; i++) {
      // Iterate over each key-value pair in the options map
      mCQS[i].options.values.forEach((value) {
        options.add(TextEditingController(text: value));
      });
    }
    editQuestionController.text = question;

    isMultiAnswer.value = isMulti;

    Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
      titleStyle: TextStyle(
        color: Colors.black,
        fontSize: 12.sp,
      ),
      titlePadding: EdgeInsets.only(top: 5.h),
      title: 'Edit Question',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Edit the question',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: SizedBox(
              height: 50,
              width: 20.w,
              child: TextField(
                controller: editQuestionController,
                decoration: InputDecoration(
                  hintText: 'Enter the question',
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.red.withOpacity(0.5), width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                ),
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Options Input Section
          Text(
            'Add the Options',
            style: GoogleFonts.poppins(fontSize: 12.sp),
          ),
          SizedBox(height: 2.h),

          // Dynamic list of options
          Obx(
                () => options.length <= 3
                ? Column(
              children: List.generate(
                options.length,
                    (index) => Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: options[index],
                            decoration: InputDecoration(
                              hintText: 'Enter option ${index + 1}',
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red.withOpacity(0.5),
                                    width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                            ),
                          )),
                      SizedBox(width: 2.w),

                      // Remove button for each option (hide for the first option)
                      if (index > 0)
                        IconButton(
                          icon: Icon(Icons.remove_circle,
                              color: Colors.red),
                          onPressed: () => removeOption(index),
                        ),
                    ],
                  ),
                ),
              ),
            )
                : Container(
              height: 35.h,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    options.length,
                        (index) => Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                                controller: options[index],
                                decoration: InputDecoration(
                                  hintText: 'Enter option ${index + 1}',
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8))),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red.withOpacity(0.5),
                                        width: 0.5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8))),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8))),
                                ),
                              )),
                          SizedBox(width: 2.w),

                          // Remove button for each option (hide for the first option)
                          if (index > 0)
                            IconButton(
                              icon: Icon(Icons.remove_circle,
                                  color: Colors.red),
                              onPressed: () => removeOption(index),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Add new option button
          TextButton.icon(
            onPressed: addNewOption,
            icon: const Icon(
              Icons.add_circle,
              color: Color(0xFF5A00FF),
            ),
            label: Text(
              'Add Option',
              style: GoogleFonts.poppins(
                  color: const Color(0xFF5A00FF), fontSize: 10.sp),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GetBuilder(builder: (AddQuestionController addQuestionController) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: CheckboxListTile(
                  value: isMultiAnswer.value == 0 ? false : true,
                  title: const Text('is Multi Select'),
                  onChanged: (bool? value) {
                    isMultiAnswer.value = (value! == true ? 1 : 0);
                    update();
                  }),
            );
          }),
        ],
      ),
      textConfirm: 'Edit',
      textCancel: 'Cancel',
      onConfirm: () {
        if (editQuestionController.text.isNotEmpty && options.isNotEmpty) {
          var optionsList =
              options.map((controller) => controller.text).toList();
          editQuestionWithOptions(
              editQuestionController.text, optionsList, questionID);
          Get.back();
        }
      },
    );
  }

  void deleteQuestion(String questionId) {
    apiCall.postAPICall(
      header: {"Authorization": "Bearer ${userModel?.token}"},
      data: {'id': questionId},
      url: APIConstant
          .questionDelete, // Corrected to use the delete API endpoint
    ).then((response) {
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Question deleted successfully');
        fetchQuestions(); // Refresh the questions list
      } else {
        Get.snackbar('Error', 'Failed to delete question');
      }
    });
  }

  Future<void> fetchQuetionsAnalysis(String id) async {
    await apiCall.getAPICall(
      "${APIConstant.questionAnalytics}/$id",
      header: {"Authorization": "Bearer ${userModel?.token}"},
    ).then(
      (value) {
        analysisData.clear();
        QuestionsAnalytics questionsAnalytics =
            QuestionsAnalytics.fromJson(value.data);
        for (int i = 0; i < questionsAnalytics.analytics.length; i++) {
          analysisData.add(
            {
              'label': questionsAnalytics.analytics[i].answer,
              'percentage': questionsAnalytics.analytics[i].per,
              'description': questionsAnalytics.analytics[i].count
            },
          );
        }
      },
    );
  }
}
