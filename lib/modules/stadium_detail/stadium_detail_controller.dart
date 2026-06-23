import 'package:get/get.dart';

import '../../data/models/stadium_model.dart';
import '../../data/models/match_model.dart';
import '../../data/repositories/world_cup_repository.dart';

class StadiumDetailController extends GetxController {
  final WorldCupRepository repo = Get.find<WorldCupRepository>();

  late final String stadiumId;

  @override
  void onInit() {
    super.onInit();
    stadiumId = Get.parameters['id'] ?? '';
  }

  StadiumModel? get stadium => repo.stadiumById(stadiumId);

  List<MatchModel> get stadiumMatches =>
      repo.matches.where((m) => m.stadiumId == stadiumId).toList();
}
