import 'dart:async'; // Import this to use Timer
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soul_sage_web/app/data/components/app_color.dart';
import '../controllers/add_chapter_controller.dart';
import '../controllers/add_module_controller.dart';

class AddModuleView extends GetView<AddModuleController> {
  AddModuleView({super.key});

  @override
  final AddModuleController controller = Get.put(AddModuleController());
  Timer? _debounce; // Add debounce Timer

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      body: GetBuilder<AddModuleController>(builder: (controller) {
        return Padding(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Module name...',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: controller.nameText,
                onChanged: (value) {
                  controller.moduleName.value = value;

                  // Cancel the previous timer if it's still active
                  if (_debounce?.isActive ?? false) _debounce!.cancel();

                  // Set a new timer to trigger after the user stops typing for 500ms
                  _debounce = Timer(const Duration(milliseconds: 3000), () {
                    controller
                        .focusOnEditor(); // Automatically move to the next widget
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter module name',
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
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
                  SizedBox(width: 2.w),
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

              SizedBox(height: 3.h),
              Text(
                'Description',
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 2.h),
              // HTML Editor
              SingleChildScrollView(
                child: Container(
                  height: Get.height * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.appColor),
                  ),
                  child: HtmlEditor(
                    controller: controller.htmlController,
                    htmlToolbarOptions: const HtmlToolbarOptions(
                      defaultToolbarButtons: [
                        FontButtons(),
                        ColorButtons(),
                        FontSettingButtons(fontName: false),
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
                      initialText: controller.moduleInstruction.value,
                      shouldEnsureVisible: true,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.resetEditor();
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
                        "Reset",
                        style: TextStyle(color: Colors.white, fontSize: 11.sp),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (controller.isModuleEdit.isFalse) {
                        await controller.addModule(controller.nameText.text);
                      } else {
                        await controller.editModule().then(
                          (value) {
                            Get.back();
                            Get.find<AddChapterController>().fetchChapter();
                          },
                        );
                      }
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
                        "Save Module",
                        style: TextStyle(color: Colors.white, fontSize: 11.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
