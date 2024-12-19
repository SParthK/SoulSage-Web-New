import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:soul_sage_web/app/data/api_service/config.dart';
import 'package:soul_sage_web/app/data/components/constants.dart';
import 'package:soul_sage_web/app/modules/AddChapter/controllers/add_chapter_controller.dart';

class AddModuleController extends GetxController {
  Uint8List? imageBytes;
  var moduleName = ''.obs;
  var moduleId = ''.obs;
  var chapterId = ''.obs;
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

  Future<dio.Response> addModule() async {
    print(await getHtmlContent());
    var data = dio.FormData.fromMap({
      'picture': [
        dio.MultipartFile.fromBytes(imageBytes!,
            filename: '${nameText.text}.png')
      ],
      "chap_id": chapterId.value,
      "name": nameText.text,
      "description": await getHtmlContent()
    });

    return await apiCall.postAPICall(
      url: APIConstant.addModules,
      header: {"Authorization": "Bearer ${userModel?.token}"},
      data: data,
    );
  }

  Future<void> editModule() async {
    var data = dio.FormData.fromMap({
      if (imageBytes != null)
        'picture': [
          dio.MultipartFile.fromBytes(imageBytes!,
              filename: '${nameText.text}.png')
        ],
      "module_id": moduleId.value,
      "chapter_id": chapterId.value.toString(),
      "name": nameText.text,
      "description": await getHtmlContent()
    });

    await apiCall.postAPICall(
      url: APIConstant.moduleEditPost,
      header: {"Authorization": "Bearer ${userModel?.token}"},
      data: data,
    );
  }

  Future<void> deleteModule() async {
    await EasyLoading.show();
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
    );
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
