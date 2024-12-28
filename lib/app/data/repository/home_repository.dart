import '../../../utils/exception_handler.dart';
import '../../base/base_repository.dart';
import '../components/constants.dart';
import '../model/dto/response.dart';
import '../model/response/generic_response.dart';

class HomeRepository extends BaseRepository {
/*  Future<RepoResponse<GenericResponse>> getOneTransporterDetails() async {
    final response = await controller.get(
      path: APIConstant.transporterList,
      query: {"type": "detail", "_id": GetStorageBox.getTransporterID()},
      bearerToken: GetStorageBox.getToken(),
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getOneTransporterSiteDetails() async {
    final response = await controller.get(
      path: APIConstant.transporterSiteList,
      query: {"type": "detail", "_id": GetStorageBox.getTransporterSiteID()},
      bearerToken: GetStorageBox.getToken(),
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getRecentClockInTime() async {
    final response = await controller.get(
      path: APIConstant.recentClockInData,
      bearerToken: GetStorageBox.getToken(),
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> userAttendanceClockInOut(
      {required UserAttendanceRequest userAttendance}) async {
    final response = await controller.post(
      path: APIConstant.clockInClockOut,
      data: userAttendance.toJson(),
      bearerToken: GetStorageBox.getToken(),
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> profileDetails() async {
    final response = await controller.get(
      path: APIConstant.profileDetails,
      bearerToken: GetStorageBox.getToken(),
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> updateProfileDetails(
      {required String userName,
      required String email,
      String? profileImgPath}) async {
    Map<String, dynamic> data = {'name': userName, 'email': email};
    if (profileImgPath != null) {
      data['profileImage'] = profileImgPath;
    }
    final response = await controller.put(
      path: APIConstant.profileDetails,
      data: data,
      bearerToken: GetStorageBox.getToken(),
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> assignedTransporter(
      {required AssignedTransporterReq oseId}) async {
    final response = await controller.get(
      path: APIConstant.assignedTransporter,
      bearerToken: GetStorageBox.getToken(),
      query: oseId.toJson(),
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> completedVehicleInspectionList() async {
    final response = await controller.get(
        path: APIConstant.vehicleInspection,
        bearerToken: GetStorageBox.getToken(),
        query: {
          "vehicleInspectionStatus": "completed",
          "transporterSiteId": GetStorageBox.getTransporterSiteID()
        });

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> pendingVehicleInspectionList() async {
    final response = await controller.get(
        path: APIConstant.vehicleInspection,
        bearerToken: GetStorageBox.getToken(),
        query: {
          "vehicleInspectionStatus": "pending",
          "transporterSiteId": GetStorageBox.getTransporterSiteID()
        });

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> transporterSiteList(
      {required String transporterId}) async {
    final response = await controller.get(
      path: APIConstant.transporterSiteList,
      bearerToken: GetStorageBox.getToken(),
      query: {"transporterId": transporterId},
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> transporterList() async {
    final response = await controller.get(
      path: APIConstant.transporterList,
      bearerToken: GetStorageBox.getToken(),
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getVehicleList() async {
    final response = await controller.get(
      path: APIConstant.vehicleList,
      query: {"transporterSiteId": GetStorageBox.getTransporterSiteID()},
      bearerToken: GetStorageBox.getToken(),
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }*/
}
