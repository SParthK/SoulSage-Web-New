import 'package:soul_sage_web/app/data/model/request/add_chapter_request.dart';

import '../../../utils/exception_handler.dart';
import '../../base/base_repository.dart';
import '../components/constants.dart';
import '../get_storage/get_storage.dart';
import '../model/dto/response.dart';
import '../model/response/generic_response.dart';

class ChapterRepository extends BaseRepository {
  Future<RepoResponse<GenericResponse>> deleteChapter(
      {required chapterId}) async {
    final response = await controller.delete(
      path: "${APIConstant.deleteChapter}/$chapterId",
      bearerToken: GetStorageBox.getToken(),
    );
    // log("message--${response}");
    // log("message--${GenericResponse.fromJson(response).toJson()}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getChapterList() async {
    final response = await controller.get(
      path: APIConstant.getChapter,
      bearerToken: GetStorageBox.getToken(),
    );
    // log("message--${response}");
    // log("message--${GenericResponse.fromJson(response).toJson()}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> addChapter(
      {required chapterData}) async {
    final response = await controller.postFormData(
        path: APIConstant.addChapter,
        bearerToken: GetStorageBox.getToken(),
        data: chapterData);
    // log("message--${response}");
    // log("message--${GenericResponse.fromJson(response).toJson()}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> editChapter(
      {required chapterData}) async {
    final response = await controller.patchFormData(
        path: APIConstant.updateChapter,
        bearerToken: GetStorageBox.getToken(),
        data: chapterData);
    // log("message--${response}");
    // log("message--${GenericResponse.fromJson(response).toJson()}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getModuleList(
      {required int chapterId}) async {
    final response = await controller.get(
        path: APIConstant.getModule,
        bearerToken: GetStorageBox.getToken(),
        query: {'chapterId': chapterId});
    // log("message--${response}");
    // log("message--${GenericResponse.fromJson(response).toJson()}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }
}
