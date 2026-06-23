import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../app/themes/app_colors.dart';
import '../../data/models/team_model.dart';

class TeamFlag extends StatelessWidget {
  final TeamModel? team;
  final String? flagUrl;
  final double size;
  final String fallback;

  const TeamFlag({
    super.key,
    this.team,
    this.flagUrl,
    this.size = 32,
    this.fallback = '🏳️',
  });

  @override
  Widget build(BuildContext context) {
    final url = flagUrl ?? team?.flag ?? '';
    if (url.isEmpty) {
      return _fallback();
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.15),
      child: CachedNetworkImage(
        imageUrl: url,
        width: size,
        height: size * 0.67,
        fit: BoxFit.cover,
        placeholder: (_, __) => _fallback(),
        errorWidget: (_, __, ___) => _fallback(),
      ),
    );
  }

  Widget _fallback() {
    return Container(
      width: size,
      height: size * 0.67,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(size * 0.15),
      ),
      child: Text(fallback, style: TextStyle(fontSize: size * 0.4)),
    );
  }
}
