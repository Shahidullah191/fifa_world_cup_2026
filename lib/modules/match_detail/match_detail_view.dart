import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/themes/app_colors.dart';
import '../../widgets/team_flag.dart';
import 'match_detail_controller.dart';

class MatchDetailView extends GetView<MatchDetailController> {
  const MatchDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final match = controller.match;
    if (match == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Match')),
        body: const Center(child: Text('Match not found')),
      );
    }

    final homeTeam = controller.repo.teamById(match.homeTeamId);
    final awayTeam = controller.repo.teamById(match.awayTeamId);
    final stadium = controller.repo.stadiumById(match.stadiumId);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppColors.headerGradient),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        match.stageLabel,
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _teamBlock(match.homeTeamName, homeTeam),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: match.homeScore != null
                                ? Text(
                                    '${match.homeScore} - ${match.awayScore}',
                                    style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'VS',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white70,
                                    ),
                                  ),
                          ),
                          _teamBlock(match.awayTeamName, awayTeam),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (match.isLive)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.live.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'LIVE ${match.timeElapsed}\'',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      else
                        Text(
                          match.localDate,
                          style: const TextStyle(color: Colors.white70),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (stadium != null) _infoCard(
                    icon: Icons.stadium,
                    title: 'Venue',
                    subtitle: stadium.nameEn,
                    detail: '${stadium.cityEn}, ${stadium.countryEn} · ${stadium.capacity.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} capacity',
                  ),
                  _infoCard(
                    icon: Icons.calendar_today,
                    title: 'Matchday',
                    subtitle: 'Day ${match.matchday}',
                    detail: match.type.toUpperCase(),
                  ),
                  if (_hasScorers(match.homeScorers)) ...[
                    const SizedBox(height: 8),
                    _scorersCard('⚽ ${match.homeTeamName} Scorers', match.homeScorers!),
                  ],
                  if (_hasScorers(match.awayScorers)) ...[
                    const SizedBox(height: 8),
                    _scorersCard('⚽ ${match.awayTeamName} Scorers', match.awayScorers!),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _teamBlock(String name, team) {
    return Column(
      children: [
        TeamFlag(team: team, size: 56),
        const SizedBox(height: 8),
        SizedBox(
          width: 100,
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  bool _hasScorers(String? scorers) {
    if (scorers == null || scorers.isEmpty || scorers == 'null') return false;
    return true;
  }

  String _formatScorers(String raw) {
    return raw
        .replaceAll('{', '')
        .replaceAll('}', '')
        .replaceAll('"', '')
        .replaceAll("'", "'")
        .split(',')
        .where((s) => s.trim().isNotEmpty)
        .join('\n');
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String detail,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
                Text(detail,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _scorersCard(String title, String scorers) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
          const SizedBox(height: 8),
          Text(
            _formatScorers(scorers),
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
