import 'package:flutter/material.dart';

import '../app/themes/app_colors.dart';
import '../data/models/group_model.dart';
import '../data/repositories/world_cup_repository.dart';
import 'team_flag.dart';

class GroupTable extends StatelessWidget {
  final GroupWithTeams groupData;
  final WorldCupRepository repo;

  const GroupTable({
    super.key,
    required this.groupData,
    required this.repo,
  });

  @override
  Widget build(BuildContext context) {
    final standings = groupData.group.sortedStandings();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    groupData.group.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Group Standings',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _headerRow(),
          ...standings.asMap().entries.map((entry) {
            final index = entry.key;
            final standing = entry.value;
            final team = groupData.teamFor(standing.teamId);
            final isQualified = index < 2 && standing.played > 0;

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isQualified
                    ? AppColors.primary.withValues(alpha: 0.08)
                    : null,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.surfaceLight.withValues(alpha: 0.5),
                  ),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 24,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: isQualified
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  TeamFlag(team: team, size: 28),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: Text(
                      team?.nameEn ?? 'Team ${standing.teamId}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _stat(standing.played.toString()),
                  _stat('${standing.won}-${standing.drawn}-${standing.lost}'),
                  _stat('${standing.goalsFor}:${standing.goalsAgainst}'),
                  _stat(
                    standing.goalDiff >= 0
                        ? '+${standing.goalDiff}'
                        : '${standing.goalDiff}',
                  ),
                  _stat(
                    standing.points.toString(),
                    bold: true,
                    color: AppColors.accent,
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _headerRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 24),
          const SizedBox(width: 28 + 8),
          const Expanded(
            flex: 3,
            child: Text('#', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
          ),
          _header('P'),
          _header('W-D-L'),
          _header('GF:GA'),
          _header('GD'),
          _header('PTS'),
        ],
      ),
    );
  }

  Widget _header(String text) {
    return SizedBox(
      width: 36,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
      ),
    );
  }

  Widget _stat(String text, {bool bold = false, Color? color}) {
    return SizedBox(
      width: 36,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
          color: color ?? AppColors.textPrimary,
        ),
      ),
    );
  }
}
