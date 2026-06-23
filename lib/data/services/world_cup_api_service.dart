import '../../core/constants/api_constants.dart';
import '../../core/network/api_client.dart';
import '../models/group_model.dart';
import '../models/match_model.dart';
import '../models/stadium_model.dart';
import '../models/team_model.dart';

class WorldCupApiService {
  final ApiClient _client;

  WorldCupApiService(this._client);

  Future<List<MatchModel>> fetchMatches() async {
    final data = await _client.get('${ApiConstants.baseUrl}${ApiConstants.games}');
    final games = data['games'] as List<dynamic>? ?? [];
    return games
        .map((e) => MatchModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<TeamModel>> fetchTeams() async {
    final data = await _client.get('${ApiConstants.baseUrl}${ApiConstants.teams}');
    final teams = data['teams'] as List<dynamic>? ?? [];
    return teams
        .map((e) => TeamModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<GroupModel>> fetchGroups() async {
    final data = await _client.get('${ApiConstants.baseUrl}${ApiConstants.groups}');
    final groups = data['groups'] as List<dynamic>? ?? [];
    return groups
        .map((e) => GroupModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<StadiumModel>> fetchStadiums() async {
    final data =
        await _client.get('${ApiConstants.baseUrl}${ApiConstants.stadiums}');
    final stadiums = data['stadiums'] as List<dynamic>? ?? [];
    return stadiums
        .map((e) => StadiumModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
