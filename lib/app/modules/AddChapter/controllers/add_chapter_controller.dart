import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:sizer/sizer.dart';
import 'package:soul_sage_web/app/data/api_service/config.dart';
import 'package:soul_sage_web/app/data/components/constants.dart';
import 'package:dio/dio.dart' as dio;

import '../../../data/api_response_model/chapter_response_model.dart';
import '../../../data/api_response_model/module_response_model.dart';
import '../../../data/components/app_color.dart';

class AddChapterController extends GetxController {
  final HtmlEditorController htmlController = HtmlEditorController();
  var chapters = <ChapterDataset>[].obs;
  var filteredChapters = <ChapterDataset>[].obs;
  var expandedChapters = <int, bool>{}.obs;
  RxInt selectedOption = 0.obs;
  RxString description = "".obs;

  var imageLink = "".obs;

  Uint8List? imageBytes;

  @override
  void onInit() {
    fetchChapter();
    super.onInit();
  }

  bool isExpanded(int index) {
    return expandedChapters[index] ?? false;
  }

  // Method to fetch chapters from the server
  Future<void> fetchChapter() async {
    // try {
    await EasyLoading.show();
    final chapterResponse = await apiCall.getAPICall(APIConstant.chapterList,
        header: {"Authorization": "Bearer ${userModel?.token}"});

    AddChapter addChapter = AddChapter.fromJson(chapterResponse.data);

    // Fetch modules and map them to chapters
    final moduleResponse = await apiCall.getAPICall(APIConstant.moduleList,
        header: {"Authorization": "Bearer ${userModel?.token}"});

    ModuleModel moduleModel = ModuleModel.fromJson(moduleResponse.data);
    chapters.clear();
    await EasyLoading.dismiss();
    for (var chapter in addChapter.chapters) {
      List<ModuleDataset> moduleListPerChapter = [];

      // Match modules to chapters
      for (var module in moduleModel.modules) {
        if (chapter.chapterId.toString() == module.chapterId.toString()) {
          moduleListPerChapter.add(
            ModuleDataset(
              moduleId: module.moduleId.toString(),
              moduleIndex: module.moduleIndex,
              moduleImage: module.picture,
              moduleName: module.name,
              moduleDescription: module.description,
            ),
          );
        }
      }

      // Create ChapterDataset and add to chapters
      ChapterDataset chapterDataset = ChapterDataset(
        chapterId: chapter.chapterId,
        isFree: chapter.isFree,
        chapterImage: chapter.picture,
        number: chapter.chapterIndex,
        name: chapter.name,
        instruction: chapter.instructions[0].description,
        modules: moduleListPerChapter,
      );

      chapters.add(chapterDataset);
      await EasyLoading.dismiss();
    }
    update();
    // } catch (e) {
    //   if (kDebugMode) {
    //     print("Error fetching chapters: $e");
    //   }
    // }
  }

  // Method to pick an image from the web
  Future<void> pickImageIconForWeb() async {
    // Use ImagePickerWeb to get the image bytes
    Uint8List? pickedBytes = await ImagePickerWeb.getImageAsBytes();

    if (pickedBytes != null) {
      imageBytes = pickedBytes;
      update(); // Update the UI after picking the image
    }
  }

  // Add a new chapter
  Future<void> addChapter(String name, int isFree) async {
    try {
      if (imageBytes != null) {
        var data = dio.FormData.fromMap({
          'picture': [
            dio.MultipartFile.fromBytes(imageBytes!, filename: '$name.png')
          ],
          'name': name,
          'is_free': isFree,
          'description': await htmlController.getText(),
        });

        await apiCall.postAPICall(
            url: APIConstant.addChapter,
            data: data,
            header: {"Authorization": "Bearer ${userModel?.token}"});

        await fetchChapter(); // Refresh the chapter list
        EasyLoading.showSuccess('Chapter added successfully');
      } else {
        EasyLoading.showError('Please select an image');
      }
    } catch (e) {
      EasyLoading.showError('Failed to add chapter');
      print("Error adding chapter: $e");
    }
  }

  // Show dialog to edit an existing chapter
  void showEditChapterDialog(
      BuildContext context, int index, ChapterDataset chapter) {
    final TextEditingController nameController =
        TextEditingController(text: chapter.name);

    Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
      title: 'Edit Chapter',
      titleStyle: TextStyle(
        color: Colors.black,
        fontSize: 12.sp,
      ),
      titlePadding: EdgeInsets.only(top: 5.h),
      content: GetBuilder(builder: (AddChapterController controller) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
          width: MediaQuery.of(context).size.width / 1.5,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SizedBox(
                          height: 50,
                          width: 20.w,
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: 'Chapter Name',
                              focusedBorder: const OutlineInputBorder(
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
                              enabledBorder: const OutlineInputBorder(
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
                          ),
                        ),
                      ),
                      Container(
                          height: 50,
                          width: 20.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                          child: customRadioTile(
                              title: 'Free',
                              value: chapter.isFree == 0 ? 1 : 0,
                              chapter: chapter)),
                    ],
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (controller.imageBytes != null)
                        // Display image from memory if it exists
                        Image.memory(
                          controller.imageBytes!,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        )
                      else if (controller.imageLink.isNotEmpty)
                        CachedNetworkImage(
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                            imageUrl: controller.imageLink.value,
                            placeholder: (context, url) =>
                                new CircularProgressIndicator(),
                            errorWidget: (context, url, error) {
                              print(error);
                              return new Icon(Icons.error);
                            })
                      else
                        // Display placeholder if no image is available
                        Container(
                          height: 60,
                          width: 60,
                          color: Colors.grey[300],
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey[600],
                          ),
                        ),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: controller.pickImageIconForWeb,
                        child: Container(
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: AppColors.appBlue),
                          ),
                          child: Center(
                            child: Text(
                              'Upload',
                              style: GoogleFonts.poppins(fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Instructions",
                  style: GoogleFonts.poppins(fontSize: 12.sp),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.appColor),
                  ),
                  child: HtmlEditor(
                    controller: controller.htmlController,
                    htmlToolbarOptions: const HtmlToolbarOptions(
                      defaultToolbarButtons: [
                        FontSettingButtons(fontName: false),
                        FontButtons(),
                        ColorButtons(),
                        InsertButtons(
                          picture: true, // Enable image insertion
                          video: true, // Enable video insertion
                        ),
                        ParagraphButtons(),
                      ],
                    ),
                    otherOptions: OtherOptions(
                      height: 400, // Explicit height for the editor
                    ),
                    htmlEditorOptions: HtmlEditorOptions(
                      hint: "Your text here...",
                      initialText: chapter.instruction,
                      shouldEnsureVisible: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      textConfirm: 'Edit',
      textCancel: 'Cancel',
      onConfirm: () {
        print("save ${chapter.isFree}");
        editChapter(nameController.text, chapter.chapterId.toString(),
                chapter.isFree)
            .then(
          (value) {
            selectedOption.value = 0;
            htmlController.clear();
            imageBytes = null;
            imageLink.value = "";
            Get.back();
          },
        );
      },
    );
  }

  // Toggle expand/collapse for chapters
  void toggleExpand(int index) {
    expandedChapters[index] = !(expandedChapters[index] ?? false);
    update(); // Update the UI after expanding/collapsing
  }

  // Filter chapters by name
  void filterChaptersByName(String query) {
    if (query.isEmpty) {
      filteredChapters.value = chapters; // Show all chapters if query is empty
    } else {
      filteredChapters.value = chapters
          .where((chapter) =>
              chapter.name.toLowerCase().contains(query.toLowerCase()))
          .toList(); // Filter chapters by name
    }
    update(); // Update the UI
  }

  // Method to delete a chapter
  Future<void> deleteChapter(int chapterIndex) async {
    // try {
    await apiCall
        .postAPICall(
            url: APIConstant.chapterDelete,
            header: {"Authorization": "Bearer ${userModel?.token}"},
            data: jsonEncode({"id": chapterIndex}))
        .then(
      (value) async {
        EasyLoading.show();
        // Refresh chapters after deletion
        EasyLoading.showSuccess('Chapter deleted successfully');
        await fetchChapter();
      },
    );
  }

  // Edit an existing chapter
  Future<void> editChapter(String name, String chapterId, int isFree) async {
    try {
      var data = dio.FormData.fromMap({
        if (imageBytes != null)
          'picture': [
            dio.MultipartFile.fromBytes(imageBytes!, filename: '$name.png')
          ],
        "id": chapterId,
        'name': name,
        "title": '',
        'is_free': isFree,
        'description': await htmlController.getText(),
      });

      await apiCall.postAPICall(
          url: APIConstant.chapterEditPost,
          data: data,
          header: {"Authorization": "Bearer ${userModel?.token}"}).then(
        (value) async {
          await fetchChapter(); // Refresh the chapter list
          EasyLoading.showSuccess('Chapter added successfully');
        },
      );
    } catch (e) {
      EasyLoading.showError('Failed to add chapter');
      if (kDebugMode) {
        print("Error adding chapter: $e");
      }
    }
  }

  Widget customRadioTile(
      {required String title,
      required int value,
      required ChapterDataset chapter}) {
    return GestureDetector(
      onTap: () {
        print(chapter.isFree);
        if (chapter.isFree == 1) {
          // Deselect by setting to 0 or any default state
          chapter.isFree = 0;
          update();
        } else {
          // Select the new value
          chapter.isFree = value;
          update();
        }
        update();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color:
            chapter.isFree == 1 ? Color(0xFF5A00FF) : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          children: [
            Icon(
              chapter.isFree == 1
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: chapter.isFree == 1
                  ? Color(0xFF5A00FF)
                  : Colors.grey,
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: chapter.isFree == 1
                    ? Color(0xFF5A00FF)
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChapterDataset {
  int number;
  int chapterId;
  String chapterImage;
  String instruction;
  int isFree;
  String name;
  List<ModuleDataset> modules;

  ChapterDataset(
      {required this.number,
      required this.name,
      required this.chapterImage,
      required this.instruction,
      required this.isFree,
      required this.chapterId,
      required this.modules});

  // Method to convert JSON into a ChapterDataset instance
  factory ChapterDataset.fromJson(Map<String, dynamic> json) {
    return ChapterDataset(
      number: json['number'],
      chapterImage: json['chapterImage'],
      instruction: json['instruction'],
      isFree: json['isFree'],
      chapterId: json['chapterId'],
      name: json['name'],
      modules: List<ModuleDataset>.from(
          json['modules'].map((module) => ModuleDataset.fromJson(module))),
    );
  }

  // Method to convert ChapterDataset instance into JSON
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'chapterImage': chapterImage,
      'isFree': isFree,
      'instruction': instruction,
      'name': name,
      'chapterId': chapterId,
      'modules': modules.map((module) => module.toJson()).toList(),
    };
  }
}

class ModuleDataset {
  String moduleId;
  int moduleIndex;
  String moduleImage;
  String moduleName;
  String moduleDescription;

  ModuleDataset(
      {required this.moduleId,
      required this.moduleIndex,
      required this.moduleDescription,
      required this.moduleImage,
      required this.moduleName});

  // Method to convert JSON into a ModuleDataset instance
  factory ModuleDataset.fromJson(Map<String, dynamic> json) {
    return ModuleDataset(
      moduleId: json['moduleId'],
      moduleDescription: json['moduleDescription'],
      moduleIndex: json['moduleIndex'],
      moduleImage: json['moduleImage'],
      moduleName: json['moduleName'],
    );
  }

  // Method to convert ModuleDataset instance into JSON
  Map<String, dynamic> toJson() {
    return {
      'moduleId': moduleId,
      'moduleIndex': moduleIndex,
      'moduleName': moduleName,
      'moduleImage': moduleImage,
      'moduleDescription': moduleDescription,
    };
  }
}
