import 'package:get/get.dart';

import 'data/network/network_request.dart';
import 'data/repository/auth_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Repositories
    Get.put(NetworkRequester(), permanent: true);
    Get.put(AuthRepository(), permanent: true);
  }
}
