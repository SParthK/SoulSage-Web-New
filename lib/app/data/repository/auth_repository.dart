import 'package:soul_sage_web/app/data/model/request/login_request.dart';

import '../../../utils/exception_handler.dart';
import '../../base/base_repository.dart';
import '../components/constants.dart';
import '../model/dto/response.dart';
import '../model/response/generic_response.dart';

class AuthRepository extends BaseRepository {
  Future<RepoResponse<GenericResponse>> logIn({required LoginRequest data}) async {
    final response =
        await controller.post(path: APIConstant.login, data: data.toJson());

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  // Future<RepoResponse<GenericResponse>> verifyOTP(
  //     {required String token,
  //     required String fcmToken,
  //     required String contactNumber}) async {
  //   final response = await controller.post(path: APIConstant.verifyOTP, data: {
  //     "firebaseVerificationToken": token,
  //     "fcmToken": fcmToken,
  //     "contactNumber": contactNumber
  //   });
  //
  //   return response is APIException
  //       ? RepoResponse(error: response)
  //       : RepoResponse(data: GenericResponse.fromJson(response));
  // }
}
