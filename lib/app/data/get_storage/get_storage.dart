import 'package:get_storage/get_storage.dart';

class GetStorageBox {
  GetStorageBox._privateConstructor();

  static String userToken = "userToken";
  static String userId = "userId";

  // static String currentSiteLat = "currentSiteLat";
  // static String currentSiteLon = "currentSiteLon";
  // static String currentSiteRadius = "currentSiteRadius";
  // static String currentClockInId = "currentClockInId";

  // static String userNumber = "userNumber";
  // static String userData = "userData";
  // static String customerIdForServiceProvider = "customerId";

  static writeStorage({required String key, required dynamic value}) async {
    await GetStorage().write(key, value);
  }

  static readStorage({dynamic key}) {
    return GetStorage().read(key);
  }

  static cleanAllStorage() async {
    await GetStorage().erase();
  }

  static String getToken() {
    return readStorage(key: GetStorageBox.userToken) ?? '';
  }

  static String getCurrentUserId() {
    return readStorage(key: GetStorageBox.userId) ?? '';
  }
}
