import 'package:get/get.dart';

import '../data/network/network_request.dart';

class BaseRepository {
  NetworkRequester get controller => GetInstance().find<NetworkRequester>();
}
