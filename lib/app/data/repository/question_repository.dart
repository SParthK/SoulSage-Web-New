import '../../../utils/exception_handler.dart';
import '../../base/base_repository.dart';
import '../components/constants.dart';
import '../get_storage/get_storage.dart';
import '../model/dto/response.dart';
import '../model/response/generic_response.dart';

class QuestionRepository extends BaseRepository {
  Future<RepoResponse<GenericResponse>> deleteQuestion(
      {required questionId}) async {
    final response = await controller.delete(
      path: "${APIConstant.deleteQue}/$questionId",
      bearerToken: GetStorageBox.getToken(),
    );
    // log("message--${response}");
    // log("message--${GenericResponse.fromJson(response).toJson()}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getQuestionList() async {
    final response = await controller.get(
      path: APIConstant.getAllQue,
      bearerToken: GetStorageBox.getToken(),
    );
    // log("message--${response}");
    // log("message--${GenericResponse.fromJson(response).toJson()}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> addQuestion(
      {required questionData}) async {
    final response = await controller.post(
        path: APIConstant.addQue,
        bearerToken: GetStorageBox.getToken(),
        data: questionData);
    // log("message--${response}");
    // log("message--${GenericResponse.fromJson(response).toJson()}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getQuestionAnalysis(
      {required int questionID}) async {
    final response = await controller.get(
      path: "${APIConstant.questionAnalysis}/$questionID",
      bearerToken: GetStorageBox.getToken(),
    );
    // log("message--${response}");
    // log("message--${GenericResponse.fromJson(response).toJson()}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getQuestionAnsWithUser(
      {required int pageNumber,
      required int questionId,
      required String mcqKey}) async {
    final response = await controller.post(
      path: APIConstant.getQueAnsWithUser,
      data: {
        "mcqKey": mcqKey,
        "id": questionId,
        "limit": 10,
        "page": pageNumber
      },
      bearerToken: GetStorageBox.getToken(),
    );
    // log("message--${response}");
    // log("message--${GenericResponse.fromJson(response).toJson()}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> editQuestion(
      {required questionData}) async {
    final response = await controller.patch(
        path: APIConstant.updateQue,
        bearerToken: GetStorageBox.getToken(),
        data: questionData);
    // log("message--${response}");
    // log("message--${GenericResponse.fromJson(response).toJson()}");
    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }
}
