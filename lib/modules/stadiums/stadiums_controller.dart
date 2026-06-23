import 'package:get/get.dart';

import '../../data/models/stadium_model.dart';
import '../../data/repositories/world_cup_repository.dart';

class StadiumsController extends GetxController {
  final WorldCupRepository repo = Get.find<WorldCupRepository>();
  final selectedCountry = ''.obs;

  List<String> get countries {
    final set = repo.stadiums.map((s) => s.countryEn).toSet().toList();
    set.sort();
    return set;
  }

  List<StadiumModel> get filteredStadiums {
    var list = List<StadiumModel>.from(repo.stadiums)
      ..sort((a, b) => b.capacity.compareTo(a.capacity));

    if (selectedCountry.value.isNotEmpty) {
      list = list.where((s) => s.countryEn == selectedCountry.value).toList();
    }
    return list;
  }

  void setCountry(String country) => selectedCountry.value = country;
  void clearCountry() => selectedCountry.value = '';
  Future<void> reload() => repo.loadAll(silent: true);
}
