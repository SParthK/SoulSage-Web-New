import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:sizer/sizer.dart';
import 'package:soul_sage_web/app/data/api_service/config.dart';
import 'package:soul_sage_web/app/data/components/constants.dart';
import 'package:dio/dio.dart' as dio;
import 'package:soul_sage_web/app/data/get_storage/get_storage.dart';
import 'package:soul_sage_web/app/data/model/response/chapter_list_response.dart';
import 'package:soul_sage_web/app/data/model/response/module_list_response.dart';
import 'package:soul_sage_web/app/data/repository/chapter_repository.dart';

import '../../../../utils/app_utils.dart';
import '../../../../utils/exception_handler.dart';
import '../../../data/components/app_color.dart';
import '../../../data/model/response/generic_response.dart';

class AddChapterController extends GetxController {
  final ChapterRepository _chapterRepository = ChapterRepository();
  final HtmlEditorController htmlController = HtmlEditorController();

  // var chapters = <ChapterDataset>[].obs;
  // var filteredChapters = <ChapterDataset>[].obs;
  RxInt selectedChapter = 0.obs;
  RxBool isLoadingChapter = false.obs;
  RxBool isLoadingModule = false.obs;
  RxList<ChapterListResponse> chapters = <ChapterListResponse>[].obs;
  RxList<ModuleListResponse> chapterModule = <ModuleListResponse>[].obs;
  RxList<ChapterListResponse> filteredChapters = <ChapterListResponse>[].obs;
  var expandedChapters = <int, bool>{}.obs;
  RxInt selectedOption = 0.obs;
  RxString description = "".obs;
  RxList<String> langList = <String>["english", "hindi", "gujarati"].obs;
  RxString selectedLang = "".obs;

  var imageLink = "".obs;

  Uint8List? imageBytes;

  @override
  void onInit() {
    fetchChapter();
    super.onInit();
  }

  onChangeLang({required String val}) {
    selectedLang.value = val;
    //TODO for change add data fields
  }

  onSelectChapter({required int selectedChapterId}) async {
    selectedChapter.value = selectedChapterId;
    await fetchModule();
  }

  bool isExpanded(int index) {
    log("message ---- $index");
    return expandedChapters[index] ?? false;
  }

  Future<void> fetchChapter() async {
    try {
      isLoadingChapter.value = true;
      await EasyLoading.show();
      final response = await _chapterRepository.getChapterList();
      if (response.data?.success == true && response.data?.data != null) {
        List<ChapterListResponse> chapterData = [];
        for (var i = 0; i < (response.data?.data).length; i++) {
          chapterData.add(ChapterListResponse.fromJson(response.data?.data[i]));
        }
        chapters.value = chapterData;
      } else {
        AppUtils.showToast(msg: response.data?.message ?? '');
      }
    } catch (e) {
      log("message-=----$e");
    } finally {
      isLoadingChapter.value = false;
      chapters.refresh();
      update();
      await EasyLoading.dismiss();
    }
  }

  Future<void> fetchModule() async {
    try {
      isLoadingModule.value = true;
      await EasyLoading.show();
      final response = await _chapterRepository.getModuleList(
          chapterId: selectedChapter.value);
      if (response.data?.success == true && response.data?.data != null) {
        List<ModuleListResponse> moduleData = [];
        for (var i = 0; i < (response.data?.data).length; i++) {
          moduleData.add(ModuleListResponse.fromJson(response.data?.data[i]));
        }
        chapterModule.value = moduleData;
      } else {
        AppUtils.showToast(msg: response.data?.message ?? '');
      }
    } catch (e) {
      log("message-=----$e");
    } finally {
      expandedChapters.clear();
      isLoadingModule.value = false;
      chapterModule.refresh();
      update();
      await EasyLoading.dismiss();
    }
  }

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
    String description = await htmlController.getText();
    await EasyLoading.show();
    Map<String, dynamic> chapterData = {
      'picture': dio.MultipartFile.fromBytes(imageBytes!,
          filename: '$name.png', contentType: MediaType('png', 'png')),
      'name': name,
      // "chapter_index": 11,
      "language_type": "EN",
      'is_free': isFree == 0 ? false : true,
      'description': description,
    };
    try {
      final response =
          await _chapterRepository.addChapter(chapterData: chapterData);
      if (response.data?.success == true) {
        EasyLoading.showSuccess('Chapter added successfully');
        await fetchChapter(); // Refresh the chapter list
        Get.back();
      } else {
        EasyLoading.showError('Please select an image');
      }
    } catch (e) {
      EasyLoading.showError('Failed to add chapter');
    } finally {
      await EasyLoading.dismiss();
    }
  }

  // Show dialog to edit an existing chapter
  void showEditChapterDialog(
      BuildContext context, int index, ChapterListResponse chapter) {
    final TextEditingController nameController = TextEditingController(
      text: chapter.chapterLanguage
              ?.firstWhere(
                (element) => element.languageType == "EN",
              )
              .name ??
          "",
    );

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
                              value: chapter.isFree == true ? 1 : 0,
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
              SingleChildScrollView(
                child: Container(
                  height: Get.height * 0.35,
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
                      initialText: chapter.instructions
                          ?.firstWhere(
                            (element) => element.languageType == "EN",
                          )
                          .description,
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
        editChapter(
                nameController.text,
                (chapter.id ?? 0).toInt(),
                chapter.isFree == true ? 1 : 0,
                (chapter.instructions?.first.id ?? 0).toInt())
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
  void toggleExpand(int index) async {
    expandedChapters.clear();
    await onSelectChapter(selectedChapterId: (chapters[index].id ?? 0).toInt());
    // if (chapterModule.isNotEmpty) {
    expandedChapters[index] = !(expandedChapters[index] ?? false);
    // }
    log("message-=--- ${expandedChapters}");

    update(); // Update the UI after expanding/collapsing
  }

  // Filter chapters by name
  void filterChaptersByName(String query) {
    if (query.isEmpty) {
      filteredChapters.value = chapters; // Show all chapters if query is empty
    } else {
      filteredChapters.value = chapters
          .where((chapter) =>
              ((chapter.chapterLanguage?.firstWhere(
                (element) => element.languageType == "EN",
              ))?.name?.toLowerCase().contains(query.toLowerCase())) ??
              false)
          .toList(); // Filter chapters by name
    }
    update(); // Update the UI
  }

  // Method to delete a chapter
  Future<void> deleteChapter(int chapterId) async {
    EasyLoading.show();

    try {
      final response =
          await _chapterRepository.deleteChapter(chapterId: chapterId);
      if (response.data?.success == true) {
        await fetchChapter();
        EasyLoading.showSuccess('Chapter deleted successfully');
      } else {
        EasyLoading.showSuccess(response.data?.message ?? "");
      }
    } catch (e) {
      log("message-=----$e");
    } finally {
      update();
      await EasyLoading.dismiss();
    }

    // try {
    // await apiCall
    //     .postAPICall(
    //         url: APIConstant.chapterDelete,
    //         header: {"Authorization": "Bearer ${userModel?.token}"},
    //         data: jsonEncode({"id": chapterIndex}))
    //     .then(
    //   (value) async {
    //     EasyLoading.show();
    //     // Refresh chapters after deletion
    //     EasyLoading.showSuccess('Chapter deleted successfully');
    //     await fetchChapter();
    //   },
    // );
  }

  // Edit an existing chapter
  Future<void> editChapter(
      String name, int chapterId, int isFree, int instructionsId) async {
    String description = await htmlController.getText();
    await EasyLoading.show();
    Map<String, dynamic> chapterData = {
      if (imageBytes != null)
        'picture': dio.MultipartFile.fromBytes(imageBytes!,
            filename: '$name.png', contentType: MediaType('png', 'png')),
      'name': name,
      'is_free': isFree == 0 ? false : true,
      "language_type": "EN",
      'description': description,
      "instructionsId": instructionsId,
      "chapter_id": chapterId,
      "language_id": 1
    };
    try {
      final response =
          await _chapterRepository.editChapter(chapterData: chapterData);
      if (response.data?.success == true) {
        EasyLoading.showSuccess('Chapter updated successfully');
        await fetchChapter(); // Refresh the chapter list
        Get.back();
      } else {
        EasyLoading.showError('Please select an image');
      }
    } catch (e) {
      EasyLoading.showError('Failed to add chapter');
      print("Error adding chapter: $e");
    } finally {
      await EasyLoading.dismiss();
    }
  }

  Widget customRadioTile(
      {required String title,
      required int value,
      required ChapterListResponse chapter}) {
    return GestureDetector(
      onTap: () {
        print(chapter.isFree);
        // if (chapter.isFree == true) {
        //   // Deselect by setting to 0 or any default state
        //   chapter.isFree = 0;
        //   update();
        // } else {
        //   // Select the new value
        //   chapter.isFree = value;
        //   update();
        // }
        update();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: chapter.isFree == 1 ? Color(0xFF5A00FF) : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          children: [
            Icon(
              chapter.isFree == true
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: chapter.isFree == true ? Color(0xFF5A00FF) : Colors.grey,
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color:
                    chapter.isFree == true ? Color(0xFF5A00FF) : Colors.black,
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
