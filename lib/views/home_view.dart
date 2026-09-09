import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/status_badge.dart';
import 'cargos_view.dart';
import 'actor_device_view.dart';
import 'requests_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AppTab _currentTab = AppTab.home;

  void _onTabSelected(AppTab tab) {
    if (tab == AppTab.home) return;
    if (tab == AppTab.requests) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const RequestsView()),
      );
      return;
    }
    if (tab == AppTab.cargos) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const CargosView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(
              onAvatarTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ActorDeviceView()),
                );
              },
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                children: [
                  _PendingRequestsCard(),
                  const SizedBox(height: 16),
                  _RecentActivityCard(),
                  const SizedBox(height: 16),
                  _CargosCard(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: _currentTab,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}

/// Shared card shell used by every section on the home screen,
/// so spacing/border/radius stays identical across sections.
class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: child,
    );
  }
}

Widget _sectionHeader(String title, String trailing, {Color? trailingColor}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: AppColors.sectionLabel,
          letterSpacing: 0.3,
        ),
      ),
      Text(
        trailing,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: trailingColor ?? AppColors.sectionLabel,
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Pending requests
// ---------------------------------------------------------------------------

class _PendingRequestsCard extends StatelessWidget {
  // TODO: replace with the real list from the backend/database.
  final List<_PendingRequest> _requests = const [
    _PendingRequest(
      icon: Icons.list_alt_rounded,
      title: 'RELEASE_CARGO',
      badgeLabel: 'AWAITING EVIDENCE',
      tone: StatusTone.pending,
      leftLabel: 'RESOURCE',
      leftValue: 'CT-928411',
      rightLabel: 'TARGET ZONE',
      rightValue: 'PORT_GATE_17',
    ),
    _PendingRequest(
      icon: Icons.error_outline_rounded,
      title: 'PERIMETER_OVERRIDE',
      badgeLabel: 'REQUIRES APPROVAL',
      tone: StatusTone.pending,
      leftLabel: 'ACCESS SECTOR',
      leftValue: 'DOC_BY_04',
      rightLabel: 'PRIORITY / LEVEL',
      rightValue: 'HIGH (LVL-2)',
    ),
  ];

  _PendingRequestsCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader(
            'PENDING REQUESTS',
            '${_requests.length} PENDING',
            trailingColor: AppColors.statusPending,
          ),
          const SizedBox(height: 12),
          for (final request in _requests) ...[
            _PendingRequestTile(request: request),
            if (request != _requests.last) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _PendingRequest {
  final IconData icon;
  final String title;
  final String badgeLabel;
  final StatusTone tone;
  final String leftLabel;
  final String leftValue;
  final String rightLabel;
  final String rightValue;

  const _PendingRequest({
    required this.icon,
    required this.title,
    required this.badgeLabel,
    required this.tone,
    required this.leftLabel,
    required this.leftValue,
    required this.rightLabel,
    required this.rightValue,
  });
}

class _PendingRequestTile extends StatelessWidget {
  final _PendingRequest request;
  const _PendingRequestTile({required this.request});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.innerFill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(request.icon, size: 16, color: AppColors.primaryTeal),
              const SizedBox(width: 6),
              Text(
                request.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              StatusBadge(label: request.badgeLabel, tone: request.tone),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _LabelValue(
                  label: request.leftLabel,
                  value: request.leftValue,
                ),
              ),
              Expanded(
                child: _LabelValue(
                  label: request.rightLabel,
                  value: request.rightValue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LabelValue extends StatelessWidget {
  final String label;
  final String value;
  const _LabelValue({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: AppColors.sectionLabel),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Recent activity
// ---------------------------------------------------------------------------

class _RecentActivityCard extends StatelessWidget {
  // TODO: replace with the real-time activity log from the backend.
  final List<_ActivityItem> _items = const [
    _ActivityItem(
      id: 'ZG-AUTH-81921',
      label: 'APPROVED',
      tone: StatusTone.positive,
      icon: Icons.check_circle_rounded,
    ),
    _ActivityItem(
      id: 'ZG-AUTH-81919',
      label: 'BLOCKED',
      tone: StatusTone.negative,
      icon: Icons.block_rounded,
    ),
    _ActivityItem(
      id: 'ZG-AUTH-81915',
      label: 'HOLD',
      tone: StatusTone.pending,
      icon: Icons.hourglass_bottom_rounded,
    ),
  ];

  _RecentActivityCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('RECENT ACTIVITY', 'Real-time log'),
          const SizedBox(height: 12),
          for (final item in _items) ...[
            Row(
              children: [
                Icon(item.icon, size: 18, color: _toneColor(item.tone)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.id,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                StatusBadge(label: item.label, tone: item.tone),
              ],
            ),
            if (item != _items.last)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: AppColors.cardBorder),
              ),
          ],
        ],
      ),
    );
  }

  Color _toneColor(StatusTone tone) {
    switch (tone) {
      case StatusTone.positive:
        return AppColors.statusApproved;
      case StatusTone.negative:
        return AppColors.statusBlocked;
      case StatusTone.pending:
        return AppColors.statusPending;
      case StatusTone.neutral:
        return const Color(0xFF6B7A83);
    }
  }
}

class _ActivityItem {
  final String id;
  final String label;
  final StatusTone tone;
  final IconData icon;
  const _ActivityItem({
    required this.id,
    required this.label,
    required this.tone,
    required this.icon,
  });
}

// ---------------------------------------------------------------------------
// Cargos
// ---------------------------------------------------------------------------

class _CargosCard extends StatelessWidget {
  // TODO: replace with the real active-units list from the backend.
  final List<_CargoItem> _cargos = const [
    _CargoItem(
      id: 'CT-928411',
      subtitle: 'In Handoff Zone',
      badgeLabel: 'AWAITING EVIDENCE',
      tone: StatusTone.pending,
      icon: Icons.inventory_2_rounded,
    ),
    _CargoItem(
      id: 'CT-928499',
      subtitle: 'In Transit / Dock 4',
      badgeLabel: 'CLEARED',
      tone: StatusTone.positive,
      icon: Icons.local_shipping_rounded,
    ),
  ];

  _CargosCard();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('CARGOS', 'Active Units'),
          const SizedBox(height: 12),
          for (final cargo in _cargos) ...[
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.innerFill,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    cargo.icon,
                    size: 17,
                    color: AppColors.primaryTeal,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cargo.id,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        cargo.subtitle,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.sectionLabel,
                        ),
                      ),
                    ],
                  ),
                ),
                StatusBadge(label: cargo.badgeLabel, tone: cargo.tone),
              ],
            ),
            if (cargo != _cargos.last)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: AppColors.cardBorder),
              ),
          ],
        ],
      ),
    );
  }
}

class _CargoItem {
  final String id;
  final String subtitle;
  final String badgeLabel;
  final StatusTone tone;
  final IconData icon;
  const _CargoItem({
    required this.id,
    required this.subtitle,
    required this.badgeLabel,
    required this.tone,
    required this.icon,
  });
}
