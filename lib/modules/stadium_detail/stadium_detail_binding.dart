import 'package:get/get.dart';

import 'stadium_detail_controller.dart';

class StadiumDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StadiumDetailController>(() => StadiumDetailController());
  }
}
