import 'dart:developer';

import 'package:soul_sage_web/app/base/base_repository.dart';

import '../../../utils/exception_handler.dart';
import '../components/constants.dart';
import '../get_storage/get_storage.dart';
import '../model/dto/response.dart';
import '../model/response/generic_response.dart';

class UserMangeRepository extends BaseRepository {
  Future<RepoResponse<GenericResponse>> getUserList(
      {required int pageNo}) async {
    final response = await controller.get(
        path: APIConstant.getUser,
        bearerToken: GetStorageBox.getToken(),
        query: {"page": pageNo, "limit": 10});
    log("message--${response}");
    log("message--${GenericResponse.fromJson(response).toJson()}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> userSubscription(
      {required userData}) async {
    final response = await controller.post(
        path: APIConstant.unlockSubscription,
        bearerToken: GetStorageBox.getToken(),
        data: userData);

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> unlockChapterTimer(
      {required userId}) async {
    final response = await controller.post(
      path: "${APIConstant.unlockChapterTimer}/$userId",
      bearerToken: GetStorageBox.getToken(),
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> deleteUser({required userId}) async {
    final response = await controller.delete(
      path: "${APIConstant.deleteUser}/$userId",
      bearerToken: GetStorageBox.getToken(),
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }
}
