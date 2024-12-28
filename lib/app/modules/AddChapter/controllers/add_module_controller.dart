import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:soul_sage_web/app/data/api_service/config.dart';
import 'package:soul_sage_web/app/data/components/constants.dart';
import 'package:soul_sage_web/app/data/repository/module_repository.dart';
import 'package:soul_sage_web/app/modules/AddChapter/controllers/add_chapter_controller.dart';

import '../../../data/get_storage/get_storage.dart';
import '../../../data/model/response/generic_response.dart';

class AddModuleController extends GetxController {
  final ModuleRepository _moduleRepository = ModuleRepository();
  Uint8List? imageBytes;
  var moduleName = ''.obs;
  var moduleId = ''.obs;
  var moduleNexIndex = 0.obs;
  var chapterId = 0.obs;
  var imageLink = ''.obs;
  var moduleInstruction = ''.obs;
  RxBool isModuleEdit = false.obs;
  TextEditingController nameText = TextEditingController();
  final HtmlEditorController htmlController = HtmlEditorController();

  // Move focus to the HTML editor

  void focusOnEditor() {
    htmlController.setFocus();
  }

  // Reset the HTML editor
  void resetEditor() {
    imageBytes = null;
    imageLink.value = "";
    nameText.clear();
    htmlController.clear();
  }

  Future<String> getHtmlContent() async {
    String result = await htmlController.getText();
    return result;
  }

  Future<void> addModule(String name) async {
    String description = await htmlController.getText();
    await EasyLoading.show();
    Map<String, dynamic> moduleData = {
      'picture': dio.MultipartFile.fromBytes(imageBytes!,
          filename: '$name.png', contentType: MediaType('png', 'png')),
      'name': nameText.text,
      "chapter_id": chapterId.value,
      // "module_index": moduleNexIndex.value,
      "language_type": "EN",
      'description': description,
    };
    /*  dio.FormData moduleData = dio.FormData.fromMap({
      'picture': dio.MultipartFile.fromBytes(imageBytes!,
          filename: '$name.png', contentType: MediaType('png', 'png')),
      'name': nameText.text,
      "chapter_id": chapterId.value,
      // "module_index": moduleNexIndex.value,
      "language_type": "EN",
      'description': description,
    });
    log("message-----==- ${moduleData.fields}");*/
    try {
      final response =
          await _moduleRepository.addModule(moduleData: moduleData);
      if (response.data?.success == true) {
        EasyLoading.showSuccess('module added successfully');
        await Get.find<AddChapterController>().fetchModule();
        Get.back();
      } else {
        EasyLoading.showError('Please select an image');
      }
    } catch (e) {
      EasyLoading.showError('Failed to add module');
      print("Error adding chapter: $e");
    } finally {
      await EasyLoading.dismiss();
    }
  }

  Future<void> editModule() async {
    Map<String, dynamic> moduleData = {
      if (imageBytes != null)
        'picture': [
          dio.MultipartFile.fromBytes(imageBytes!,
              filename: '${nameText.text}.png')
        ],
      "module_id": moduleId.value,
      "chapter_id": chapterId.value.toString(),
      "name": nameText.text,
      "description": await getHtmlContent()
    };

    try {
      final response =
      await _moduleRepository.editModule(moduleData: moduleData);
      if (response.data?.success == true) {
        EasyLoading.showSuccess('module updated successfully');
        await Get.find<AddChapterController>().fetchModule();
        Get.back();
      } else {
        EasyLoading.showError('Please select an image');
      }
    } catch (e) {
      EasyLoading.showError('Failed to update module');
      print("Error adding chapter: $e");
    } finally {
      await EasyLoading.dismiss();
    }
    // var data = dio.FormData.fromMap({
    //   if (imageBytes != null)
    //     'picture': [
    //       dio.MultipartFile.fromBytes(imageBytes!,
    //           filename: '${nameText.text}.png')
    //     ],
    //   "module_id": moduleId.value,
    //   "chapter_id": chapterId.value.toString(),
    //   "name": nameText.text,
    //   "description": await getHtmlContent()
    // });

    // await apiCall.postAPICall(
    //   url: APIConstant.moduleEditPost,
    //   header: {"Authorization": "Bearer ${userModel?.token}"},
    //   data: data,
    // );

  }

  Future<void> deleteModule() async {
    EasyLoading.show();
    try {
      final response = await _moduleRepository.deleteModule(moduleId: moduleId);
      if (response.data?.success == true) {
        await Get.find<AddChapterController>().fetchModule();
        EasyLoading.showSuccess('Module deleted successfully');
      } else {
        EasyLoading.showSuccess(response.data?.message ?? "");
      }
    } catch (e) {
      log("message-=----$e");
    } finally {
      update();
      await EasyLoading.dismiss();
    }
    /*await EasyLoading.show();
    await apiCall
        .postAPICall(
      url: APIConstant.moduleDelete,
      header: {"Authorization": "Bearer ${userModel?.token}"},
      data: jsonEncode({"id": moduleId.value.toString()}),
    )
        .then(
      (value) {
        Get.find<AddChapterController>().fetchChapter().then(
          (value) async {
            await EasyLoading.dismiss();
          },
        );
      },
    );*/
  }

  Future<void> pickImageIconForWeb() async {
    // Use ImagePickerWeb to get the image bytes
    Uint8List? pickedBytes = await ImagePickerWeb.getImageAsBytes();

    if (pickedBytes != null) {
      imageBytes = pickedBytes;
      update(); // Update the UI after picking the image
    }
  }
}
