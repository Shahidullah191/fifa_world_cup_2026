import 'package:get/get.dart';

import 'match_detail_controller.dart';

class MatchDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MatchDetailController>(() => MatchDetailController());
  }
}
