import 'package:flutter/material.dart';

import '../app/themes/app_colors.dart';
import '../data/models/match_model.dart';
import '../data/models/team_model.dart';
import '../data/repositories/world_cup_repository.dart';
import 'team_flag.dart';

class MatchCard extends StatelessWidget {
  final MatchModel match;
  final WorldCupRepository repo;
  final VoidCallback? onTap;

  const MatchCard({
    super.key,
    required this.match,
    required this.repo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final homeTeam = repo.teamById(match.homeTeamId);
    final awayTeam = repo.teamById(match.awayTeamId);
    final stadium = repo.stadiumById(match.stadiumId);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: match.isLive
                ? AppColors.live.withValues(alpha: 0.5)
                : AppColors.surfaceLight,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _stageChip(),
                if (match.isLive) _liveBadge() else _dateLabel(),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _teamColumn(match.homeTeamName, homeTeam, true)),
                _scoreSection(),
                Expanded(child: _teamColumn(match.awayTeamName, awayTeam, false)),
              ],
            ),
            if (stadium != null) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.stadium_outlined,
                      size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      '${stadium.nameEn}, ${stadium.cityEn}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _stageChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        match.stageLabel,
        style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
      ),
    );
  }

  Widget _liveBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.live.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.live,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            match.timeElapsed == 'finished' ? 'FT' : "${match.timeElapsed}'",
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.live,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateLabel() {
    return Text(
      match.localDate,
      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
    );
  }

  Widget _teamColumn(String name, TeamModel? team, bool alignEnd) {
    return Column(
      children: [
        TeamFlag(team: team, size: 40),
        const SizedBox(height: 8),
        Text(
          name,
          textAlign: alignEnd ? TextAlign.end : TextAlign.start,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _scoreSection() {
    final hasScore = match.homeScore != null && match.awayScore != null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: hasScore
          ? Text(
              '${match.homeScore} - ${match.awayScore}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            )
          : const Text(
              'VS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),
    );
  }
}
