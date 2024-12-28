import '../../../utils/exception_handler.dart';
import '../../base/base_repository.dart';
import '../components/constants.dart';
import '../get_storage/get_storage.dart';
import '../model/dto/response.dart';
import '../model/response/generic_response.dart';

class ModuleRepository extends BaseRepository {
  Future<RepoResponse<GenericResponse>> deleteModule(
      {required moduleId}) async {
    final response = await controller.delete(
      path: "${APIConstant.deleteModule}/$moduleId",
      bearerToken: GetStorageBox.getToken(),
    );
    // log("message--${response}");
    // log("message--${GenericResponse.fromJson(response).toJson()}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> addModule(
      {required moduleData}) async {
    final response = await controller.postFormData(
        path: APIConstant.addModule,
        bearerToken: GetStorageBox.getToken(),
        data: moduleData);
    // log("message--${response}");
    // log("message--${GenericResponse.fromJson(response).toJson()}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> editModule(
      {required moduleData}) async {
    final response = await controller.patchFormData(
        path: APIConstant.updateModule,
        bearerToken: GetStorageBox.getToken(),
        data: moduleData);
    // log("message--${response}");
    // log("message--${GenericResponse.fromJson(response).toJson()}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }
}
