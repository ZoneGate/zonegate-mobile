import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/status_badge.dart';
import '../widgets/status_filter_chip.dart';
import 'cargos_view.dart';
import 'actor_device_view.dart';
import 'home_view.dart';
import 'receipt_detail_view.dart';

class _AuthEntry {
  final String id;
  final String time;
  final String route;
  final String relativeTime;
  final StatusTone tone;

  const _AuthEntry({
    required this.id,
    required this.time,
    required this.route,
    required this.relativeTime,
    required this.tone,
  });
}

class RequestsView extends StatefulWidget {
  const RequestsView({super.key});

  @override
  State<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  final List<_AuthEntry> _entries = const [
    _AuthEntry(
      id: 'ZG-AUTH-81921',
      time: '10:44 UTC',
      route: 'GATE-12 · BAY-04',
      relativeTime: '2m ago',
      tone: StatusTone.positive,
    ),
    _AuthEntry(
      id: 'ZG-AUTH-81920',
      time: '10:41 UTC',
      route: 'GATE-09 · NORTH',
      relativeTime: '5m ago',
      tone: StatusTone.positive,
    ),
    _AuthEntry(
      id: 'ZG-AUTH-81919',
      time: '10:39 UTC',
      route: 'GATE-03 · AIRLOCK 1',
      relativeTime: '12m ago',
      tone: StatusTone.negative,
    ),
    _AuthEntry(
      id: 'ZG-AUTH-81915',
      time: '10:35 UTC',
      route: 'SECTOR B · QUARANTINE',
      relativeTime: '16m ago',
      tone: StatusTone.pending,
    ),
    _AuthEntry(
      id: 'ZG-AUTH-81912',
      time: '10:28 UTC',
      route: 'GATE-12 · BAY-02',
      relativeTime: '28m ago',
      tone: StatusTone.positive,
    ),
    _AuthEntry(
      id: 'ZG-AUTH-81908',
      time: '10:20 UTC',
      route: 'PERIMETER GATE 1B',
      relativeTime: '36m ago',
      tone: StatusTone.negative,
    ),
    _AuthEntry(
      id: 'ZG-AUTH-81904',
      time: '10:14 UTC',
      route: 'GATE-08 · CUSTOMS',
      relativeTime: '42m ago',
      tone: StatusTone.negative,
    ),
    _AuthEntry(
      id: 'ZG-AUTH-81898',
      time: '10:02 UTC',
      route: 'SECTOR C · CUSTOMS HOLD',
      relativeTime: '54m ago',
      tone: StatusTone.pending,
    ),
  ];

  // Which filter chips are currently active. Empty set = show everything.
  final Set<StatusTone> _activeFilters = {};

  void _toggleFilter(StatusTone tone) {
    setState(() {
      if (_activeFilters.contains(tone)) {
        _activeFilters.remove(tone);
      } else {
        _activeFilters.add(tone);
      }
    });
  }

  List<_AuthEntry> get _visibleEntries {
    if (_activeFilters.isEmpty) return _entries;
    return _entries.where((e) => _activeFilters.contains(e.tone)).toList();
  }

  int _countFor(StatusTone tone) =>
      _entries.where((e) => e.tone == tone).length;

  void _onTabSelected(AppTab tab) {
    if (tab == AppTab.requests) return;
    if (tab == AppTab.home) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeView()));
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
            const Divider(height: 1, color: AppColors.cardBorder),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                children: [
                  const Text(
                    'Authorization Requests',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Cryptographic audit log & authorization records',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.sectionLabel,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      StatusFilterChip(
                        label: 'APPROVED',
                        count: _countFor(StatusTone.positive),
                        tone: StatusTone.positive,
                        isActive: _activeFilters.contains(StatusTone.positive),
                        onTap: () => _toggleFilter(StatusTone.positive),
                      ),
                      StatusFilterChip(
                        label: 'BLOCKED',
                        count: _countFor(StatusTone.negative),
                        tone: StatusTone.negative,
                        isActive: _activeFilters.contains(StatusTone.negative),
                        onTap: () => _toggleFilter(StatusTone.negative),
                      ),
                      StatusFilterChip(
                        label: 'HOLD',
                        count: _countFor(StatusTone.pending),
                        tone: StatusTone.pending,
                        isActive: _activeFilters.contains(StatusTone.pending),
                        onTap: () => _toggleFilter(StatusTone.pending),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const Row(
                    children: [
                      Expanded(
                        child: Text(
                          'AUTHORIZATION ID & ROUTE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.sectionLabel,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      Text(
                        'TIMESTAMP',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.sectionLabel,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  for (final entry in _visibleEntries) ...[
                    _AuthEntryTile(entry: entry),
                    if (entry != _visibleEntries.last)
                      const Divider(height: 1, color: AppColors.cardBorder),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: AppTab.requests,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}

class _AuthEntryTile extends StatelessWidget {
  final _AuthEntry entry;
  const _AuthEntryTile({required this.entry});

  IconData get _icon {
    switch (entry.tone) {
      case StatusTone.positive:
        return Icons.check_rounded;
      case StatusTone.negative:
        return Icons.block_rounded;
      case StatusTone.pending:
        return Icons.hourglass_bottom_rounded;
      case StatusTone.neutral:
        return Icons.help_outline_rounded;
    }
  }

  Color get _color {
    switch (entry.tone) {
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

  @override
  Widget build(BuildContext context) {
    final color = _color;
    VoidCallback? onTap;
    if (entry.tone == StatusTone.positive) {
      onTap = () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ReceiptDetailView.demoSuccessFor(entry.id),
          ),
        );
      };
    } else if (entry.tone == StatusTone.negative) {
      onTap = () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ReceiptDetailView.demoRejectedFor(entry.id),
          ),
        );
      };
    } else if (entry.tone == StatusTone.pending) {
      onTap = () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ReceiptDetailView.demoHoldFor(entry.id),
          ),
        );
      };
    }

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(_icon, size: 18, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.id,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${entry.time} · ${entry.route}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.sectionLabel,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              entry.relativeTime,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.sectionLabel,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: AppColors.sectionLabel,
            ),
          ],
        ),
      ),
    );
  }
}
