import 'dart:developer';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:sizer/sizer.dart';
import 'package:soul_sage_web/app/data/model/response/chapter_list_response.dart';
import 'package:soul_sage_web/app/data/model/response/module_list_response.dart';
import '../../../data/components/app_color.dart';
import '../../../data/components/app_icons_path.dart';
import '../../../widget/common/common_dropdown.dart';
import '../controllers/add_chapter_controller.dart';
import '../controllers/add_module_controller.dart';
import 'add_module_view.dart';

class AddChapterView extends GetView<AddChapterController> {
  AddChapterView({super.key});

  final AddChapterController chapterController =
      Get.put(AddChapterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AddChapterController>(builder: (chapterController) {
        return Padding(
          padding: EdgeInsets.all(2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Add Chapter Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add chapter',
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showAddChapterDialog(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF5A00FF),
                            Color(0xFF9F00FF),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Text(
                        "+ Add chapter",
                        style: TextStyle(color: Colors.white, fontSize: 11.sp),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),

              // Chapters and Modules Table
              Expanded(
                child: chapterController.chapters.isEmpty
                    ? Center(
                        child: Text(
                          "No Chapters found!",
                          style: GoogleFonts.poppins(
                              fontSize: 2.h, fontWeight: FontWeight.w500),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children:
                              _buildChapterRows(context, chapterController),
                        ),
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Show dialog to add a new chapter
  void _showAddChapterDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
      title: 'Add Chapter',
      titleStyle: TextStyle(
        color: Colors.black,
        fontSize: 12.sp,
      ),
      titlePadding: EdgeInsets.only(top: 5.h),
      content: GetBuilder<AddChapterController>(builder: (controller) {
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
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: RadioListTile<int>(
                          title: const Text('Free'),
                          value: 1,
                          groupValue: controller.selectedOption.value,
                          onChanged: (int? value) {
                            controller.selectedOption(value);
                            controller.update();
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      controller.imageBytes != null
                          ? Image.memory(
                              controller.imageBytes!,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 60,
                              width: 60,
                              color: Colors.grey[300],
                              child: Icon(Icons.image,
                                  size: 50, color: Colors.grey[600]),
                            ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: InkWell(
                          onTap: controller.pickImageIconForWeb,
                          child: Container(
                              height: 40,
                              width: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: AppColors.appBlue)),
                              child: Center(
                                child: Text(
                                  'Upload',
                                  style: GoogleFonts.poppins(fontSize: 12.sp),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                  CommonDropdown(
                    selectedValue: '',
                    itemList: [],
                    customHeightList: [],
                    onChangeItem: (selectValue) {},
                    hintText: '',
                    titleStyle: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
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
                      shouldEnsureVisible: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      textConfirm: 'Add',
      textCancel: 'Cancel',
      onConfirm: () async {
        if (nameController.text.isNotEmpty) {
          await chapterController.addChapter(
              nameController.text, chapterController.selectedOption.value);
          _resetFields(chapterController, nameController);
          Get.back();
        }
      },
      onCancel: () {
        _resetFields(chapterController, nameController);
      },
    );
  }

  void _resetFields(
      AddChapterController controller, TextEditingController nameController) {
    nameController.clear();
    controller.selectedOption.value = 0; // Reset radio button selection
    controller.imageBytes = null; // Reset image selection
    controller.htmlController.clear(); // Clear the HTML editor
    controller.update();
  }

  // Build each chapter and its modules as nested rows
  List<Widget> _buildChapterRows(
      BuildContext context, AddChapterController controller) {
    List<Widget> rows = [];
    if (controller.filteredChapters.isNotEmpty) {
      for (var i = 0; i < controller.filteredChapters.length; i++) {
        ChapterListResponse chapter = controller.filteredChapters[i];
        rows.add(
            _buildChapterRow(context, i, chapter, controller.isExpanded(i)));

        // If the chapter is expanded, show its modules
        if (controller.isExpanded(i)) {
          for (var j = 0; j < controller.chapterModule.length; j++) {
            rows.add(
              _buildModuleRow(context, i, controller.chapterModule[j],
                  controller.chapters[i]),
            );
          }

          // Add 'Add Module' button under each chapter's modules
          rows.add(
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: GestureDetector(
                onTap: () {
                  final addModuleController = Get.put(AddModuleController());
                  addModuleController.resetEditor();
                  addModuleController.chapterId.value =
                      (controller.chapters[i].id ?? 0).toInt();
                  addModuleController.moduleNexIndex.value =
                      controller.chapterModule.length;
                  addModuleController.isModuleEdit.value = false;
                  Get.dialog(AddModuleView());
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.withOpacity(0.4)),
                  child: Text(
                    '+ Add module',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    } else {
      for (var i = 0; i < controller.chapters.length; i++) {
        ChapterListResponse chapter = controller.chapters[i];
        rows.add(
            _buildChapterRow(context, i, chapter, controller.isExpanded(i)));

        // If the chapter is expanded, show its modules
        if (controller.isExpanded(i)) {
          for (var j = 0; j < controller.chapterModule.length; j++) {
            rows.add(
              _buildModuleRow(context, i, controller.chapterModule[j],
                  controller.chapters[i]),
            );
          }

          // Add 'Add Module' button under each chapter's modules
          rows.add(
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: GestureDetector(
                onTap: () {
                  final addModuleController = Get.put(AddModuleController());
                  addModuleController.resetEditor();
                  addModuleController.chapterId.value =
                      (controller.chapters[i].id ?? 0).toInt();
                  addModuleController.moduleNexIndex.value =
                      controller.chapterModule.length;
                  addModuleController.isModuleEdit.value = false;
                  Get.dialog(AddModuleView());
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.withOpacity(0.4)),
                  child: Text(
                    '+ Add module',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    }

    return rows;
  }

  // Build the chapter row
  Widget _buildChapterRow(BuildContext context, int index,
      ChapterListResponse chapter, bool isExpanded) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          chapterController.toggleExpand(index);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.sp),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // '${chapter.number}. ',
                '${index + 1} ',
                style: GoogleFonts.poppins(fontSize: 12.sp),
              ),
              SizedBox(
                width: 1.w,
              ),
              Expanded(
                child: Text(
                  chapter.chapterLanguage
                          ?.firstWhere(
                            (element) => element.languageType == "EN",
                          )
                          .name ??
                      "NA",
                  style: GoogleFonts.poppins(fontSize: 12.sp),
                ),
              ),
              Text(
                'CH-${index + 1}, M-${(chapter.chapterModule ?? []).length}',
                // 'Pending',
                style: GoogleFonts.poppins(fontSize: 12.sp),
              ),
              SizedBox(
                width: 20.w,
              ),
              Row(
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      AppIcons.editIcon,
                      width: 13.sp,
                      height: 13.sp,
                    ),
                    onPressed: () {
                      chapterController.selectedOption.value =
                          chapter.isFree == true ? 1 : 0;
                      chapterController.imageLink.value = chapter.picture ?? "";

                      chapterController.update();
                      chapterController.showEditChapterDialog(
                          context, index, chapter);
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      AppIcons.deleteIcon,
                      width: 13.sp,
                      height: 13.sp,
                    ),
                    onPressed: () {
                      AwesomeDialog(
                        width: Get.width / 3,
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: 'are you sure you want to delete.',
                        desc: '',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          chapterController
                              .deleteChapter((chapter.id ?? 0).toInt());
                        },
                      ).show();
                    },
                  ),
                  SizedBox(
                    width: 2.w,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build the module row
  Widget _buildModuleRow(BuildContext context, int index,
      ModuleListResponse modulesInfo, ChapterListResponse chapterData) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 8, top: 8, bottom: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ((modulesInfo.moduleIndex ?? 0) + 1).toString(),
              style: GoogleFonts.poppins(fontSize: 12.sp),
            ),
            SizedBox(
              width: 1.w,
            ),
            Expanded(
              child: Text(
                modulesInfo.moduleLanguage
                        ?.firstWhere(
                          (element) => element.languageType == "EN",
                        )
                        .name ??
                    "",
                style: GoogleFonts.poppins(fontSize: 12.sp),
              ),
            ),
            SizedBox(
              width: 22.w,
            ),
            Row(
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    AppIcons.editIcon,
                    width: 13.sp,
                    height: 13.sp,
                  ),
                  onPressed: () async {
                    AddModuleController addModuleController =
                        Get.put(AddModuleController());

                    addModuleController.chapterId.value =
                        (controller.chapters[index].chapterLanguage
                                    ?.firstWhere(
                                      (element) => element.languageType == "EN",
                                    )
                                    .chapterId ??
                                0)
                            .toInt();

                    addModuleController.nameText.text =
                        modulesInfo.moduleLanguage
                                ?.firstWhere(
                                  (element) => element.languageType == "EN",
                                )
                                .name ??
                            "";
                    addModuleController.moduleId.value =
                        (modulesInfo.moduleLanguage
                                    ?.firstWhere(
                                      (element) => element.languageType == "EN",
                                    )
                                    .id ??
                                0)
                            .toString();

                    addModuleController.isModuleEdit.value = true;

                    addModuleController.moduleInstruction.value =
                        modulesInfo.moduleLanguage
                                ?.firstWhere(
                                  (element) => element.languageType == "EN",
                                )
                                .description ??
                            "";

                    addModuleController.imageLink.value =
                        modulesInfo.picture ?? "";

                    // print(
                    //     "modulesInfo.moduleDescription${modulesInfo.moduleDescription}");
                    addModuleController.update();

                    Get.dialog(AddModuleView());
                  },
                ),
                IconButton(
                  icon: SvgPicture.asset(
                    AppIcons.deleteIcon,
                    width: 13.sp,
                    height: 13.sp,
                  ),
                  onPressed: () {
                    AddModuleController addModuleController =
                        Get.put(AddModuleController());

                    addModuleController.moduleId.value =
                        (modulesInfo.id ?? 0).toString();

                    AwesomeDialog(
                      width: Get.width / 3,
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.rightSlide,
                      title: 'are you sure you want to delete?',
                      desc: '',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        addModuleController.deleteModule();
                      },
                    )..show();
                  },
                ),
                SizedBox(
                  width: 1.w,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List> convertImageToUint8List(String imageUrl) async {
    final request =
        await html.HttpRequest.request(imageUrl, responseType: 'arraybuffer');
    return Uint8List.view(request.response);
  }
}
