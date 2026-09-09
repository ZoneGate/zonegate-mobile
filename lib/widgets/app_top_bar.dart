import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'zonegate_logo.dart';

/// Top bar shared by Home, Requests, and Cargos.
class AppTopBar extends StatelessWidget {
  final String employeeId;
  final String role;
  final VoidCallback? onAvatarTap;

  const AppTopBar({
    super.key,
    this.employeeId = 'EMP-204',
    this.role = 'WAREHOUSE OPERATOR',
    this.onAvatarTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          const ZoneGateLogo(size: 28),
          const SizedBox(width: 8),
          const Text(
            'ZoneGate',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryTeal,
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                employeeId,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                role,
                style: const TextStyle(
                  fontSize: 9,
                  color: AppColors.sectionLabel,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onAvatarTap,
            child: const CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.innerFill,
              child: Icon(Icons.person, color: AppColors.iconMuted, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}
