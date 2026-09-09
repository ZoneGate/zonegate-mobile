import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/app_top_bar.dart';
import 'home_view.dart';
import 'actor_device_view.dart';
import 'requests_view.dart';

enum _CargoStatus { inInspection, shipped, preparing, hold }

enum _StepState { done, active, upcoming }

class _CargoStep {
  final String label;
  final _StepState state;
  const _CargoStep(this.label, this.state);
}

class _Cargo {
  final String id;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final _CargoStatus status;
  final String destination;
  final String ramp;
  final String extraLabel;
  final String extraValue;
  final bool extraHighlighted;
  final List<_CargoStep> steps;

  const _Cargo({
    required this.id,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.status,
    required this.destination,
    required this.ramp,
    required this.extraLabel,
    required this.extraValue,
    required this.extraHighlighted,
    required this.steps,
  });
}

class CargosView extends StatefulWidget {
  const CargosView({super.key});

  @override
  State<CargosView> createState() => _CargosViewState();
}

class _CargosViewState extends State<CargosView> {
  // TODO: replace with the real shipment list from the backend/database.
  final List<_Cargo> _cargos = const [
    _Cargo(
      id: 'CT-928411',
      description: 'Soğuk Zincir Tıbbi Kargo',
      icon: Icons.category_rounded,
      iconColor: Color(0xFF1AA260),
      iconBg: Color(0xFFE3F5EC),
      status: _CargoStatus.inInspection,
      destination: 'Gate 4B',
      ramp: 'Bay 12',
      extraLabel: '',
      extraValue: '-18.4°C',
      extraHighlighted: true,
      steps: [
        _CargoStep('1. Hazırlanıyor', _StepState.done),
        _CargoStep('2. Kontrolde', _StepState.active),
        _CargoStep('3. Sevk Edildi', _StepState.upcoming),
      ],
    ),
    _Cargo(
      id: 'CT-928499',
      description: 'Yüksek Güvenlikli Elektronik',
      icon: Icons.local_shipping_rounded,
      iconColor: Color(0xFF2F80ED),
      iconBg: Color(0xFFE7F0FC),
      status: _CargoStatus.shipped,
      destination: 'Gate 2A',
      ramp: 'Dock 4',
      extraLabel: '',
      extraValue: '#ZG-9921',
      extraHighlighted: true,
      steps: [
        _CargoStep('1. Hazırlanıyor', _StepState.done),
        _CargoStep('2. Kontrolde', _StepState.done),
        _CargoStep('3. Sevk Edildi', _StepState.done),
      ],
    ),
    _Cargo(
      id: 'CT-928504',
      description: 'Hassas Sensör Modülleri',
      icon: Icons.category_rounded,
      iconColor: Color(0xFF6D5BD0),
      iconBg: Color(0xFFEDEAFB),
      status: _CargoStatus.preparing,
      destination: 'Term. 1',
      ramp: 'Bay 08',
      extraLabel: 'Tartım:',
      extraValue: 'OK',
      extraHighlighted: false,
      steps: [
        _CargoStep('1. Hazırlanıyor', _StepState.done),
        _CargoStep('2. Kontrolde', _StepState.upcoming),
        _CargoStep('3. Sevk Edildi', _StepState.upcoming),
      ],
    ),
    _Cargo(
      id: 'CT-928520',
      description: 'Genel Kargo',
      icon: Icons.category_rounded,
      iconColor: Color(0xFF1AA260),
      iconBg: Color(0xFFE3F5EC),
      status: _CargoStatus.inInspection,
      destination: 'Gate 6',
      ramp: 'Bay 03',
      extraLabel: '',
      extraValue: '',
      extraHighlighted: false,
      steps: [
        _CargoStep('1. Hazırlanıyor', _StepState.done),
        _CargoStep('2. Kontrolde', _StepState.active),
        _CargoStep('3. Sevk Edildi', _StepState.upcoming),
      ],
    ),
    _Cargo(
      id: 'CT-928531',
      description: 'Yedek Parça Sevkiyatı',
      icon: Icons.category_rounded,
      iconColor: Color(0xFF1AA260),
      iconBg: Color(0xFFE3F5EC),
      status: _CargoStatus.inInspection,
      destination: 'Gate 11',
      ramp: 'Bay 07',
      extraLabel: '',
      extraValue: '',
      extraHighlighted: false,
      steps: [
        _CargoStep('1. Hazırlanıyor', _StepState.done),
        _CargoStep('2. Kontrolde', _StepState.active),
        _CargoStep('3. Sevk Edildi', _StepState.upcoming),
      ],
    ),
    _Cargo(
      id: 'CT-928542',
      description: 'Ambalajlı Gıda Ürünleri',
      icon: Icons.category_rounded,
      iconColor: Color(0xFF6D5BD0),
      iconBg: Color(0xFFEDEAFB),
      status: _CargoStatus.preparing,
      destination: 'Term. 2',
      ramp: 'Bay 15',
      extraLabel: '',
      extraValue: '',
      extraHighlighted: false,
      steps: [
        _CargoStep('1. Hazırlanıyor', _StepState.done),
        _CargoStep('2. Kontrolde', _StepState.upcoming),
        _CargoStep('3. Sevk Edildi', _StepState.upcoming),
      ],
    ),
    _Cargo(
      id: 'CT-928556',
      description: 'Endüstriyel Ekipman',
      icon: Icons.category_rounded,
      iconColor: Color(0xFF6D5BD0),
      iconBg: Color(0xFFEDEAFB),
      status: _CargoStatus.preparing,
      destination: 'Term. 1',
      ramp: 'Bay 05',
      extraLabel: '',
      extraValue: '',
      extraHighlighted: false,
      steps: [
        _CargoStep('1. Hazırlanıyor', _StepState.done),
        _CargoStep('2. Kontrolde', _StepState.upcoming),
        _CargoStep('3. Sevk Edildi', _StepState.upcoming),
      ],
    ),
    _Cargo(
      id: 'CT-928561',
      description: 'Gümrük Beklemesinde Kargo',
      icon: Icons.category_rounded,
      iconColor: Color(0xFFB8860B),
      iconBg: Color(0xFFFBF3E1),
      status: _CargoStatus.hold,
      destination: 'Gate 03',
      ramp: 'Bay 01',
      extraLabel: '',
      extraValue: '',
      extraHighlighted: false,
      steps: [
        _CargoStep('1. Hazırlanıyor', _StepState.done),
        _CargoStep('2. Kontrolde', _StepState.upcoming),
        _CargoStep('3. Sevk Edildi', _StepState.upcoming),
      ],
    ),
    _Cargo(
      id: 'CT-928574',
      description: 'Kimyasal Madde Sevkiyatı',
      icon: Icons.category_rounded,
      iconColor: Color(0xFFB8860B),
      iconBg: Color(0xFFFBF3E1),
      status: _CargoStatus.hold,
      destination: 'Gate 09',
      ramp: 'Bay 06',
      extraLabel: '',
      extraValue: '',
      extraHighlighted: false,
      steps: [
        _CargoStep('1. Hazırlanıyor', _StepState.done),
        _CargoStep('2. Kontrolde', _StepState.upcoming),
        _CargoStep('3. Sevk Edildi', _StepState.upcoming),
      ],
    ),
  ];

  final Set<_CargoStatus> _activeFilters = {};

  void _toggleFilter(_CargoStatus status) {
    setState(() {
      if (_activeFilters.contains(status)) {
        _activeFilters.remove(status);
      } else {
        _activeFilters.add(status);
      }
    });
  }

  List<_Cargo> get _visibleCargos {
    if (_activeFilters.isEmpty) return _cargos;
    return _cargos.where((c) => _activeFilters.contains(c.status)).toList();
  }

  int _countFor(_CargoStatus status) =>
      _cargos.where((c) => c.status == status).length;

  void _onTabSelected(AppTab tab) {
    if (tab == AppTab.cargos) return;
    if (tab == AppTab.home) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeView()));
    } else if (tab == AppTab.requests) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const RequestsView()),
      );
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
                    'Cargos & Shipments',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Active shipment and cargo tracking',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.sectionLabel,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _NeutralFilterChip(
                          label: 'IN INSPECTION',
                          count: _countFor(_CargoStatus.inInspection),
                          isActive: _activeFilters.contains(
                            _CargoStatus.inInspection,
                          ),
                          onTap: () => _toggleFilter(_CargoStatus.inInspection),
                        ),
                        const SizedBox(width: 10),
                        _NeutralFilterChip(
                          label: 'PREPARING',
                          count: _countFor(_CargoStatus.preparing),
                          isActive: _activeFilters.contains(
                            _CargoStatus.preparing,
                          ),
                          onTap: () => _toggleFilter(_CargoStatus.preparing),
                        ),
                        const SizedBox(width: 10),
                        _NeutralFilterChip(
                          label: 'HOLD',
                          count: _countFor(_CargoStatus.hold),
                          isActive: _activeFilters.contains(_CargoStatus.hold),
                          onTap: () => _toggleFilter(_CargoStatus.hold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  for (final cargo in _visibleCargos) ...[
                    _CargoCard(cargo: cargo),
                    const SizedBox(height: 14),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: AppTab.cargos,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}

class _NeutralFilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isActive;
  final VoidCallback onTap;

  const _NeutralFilterChip({
    required this.label,
    required this.count,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.innerFill : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: AppColors.innerFill,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.sectionLabel,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CargoCard extends StatelessWidget {
  final _Cargo cargo;
  const _CargoCard({required this.cargo});

  String get _statusLabel {
    switch (cargo.status) {
      case _CargoStatus.inInspection:
        return 'IN INSPECTION';
      case _CargoStatus.shipped:
        return 'SHIPPED';
      case _CargoStatus.preparing:
        return 'PREPARING';
      case _CargoStatus.hold:
        return 'HOLD';
    }
  }

  Color get _statusColor {
    switch (cargo.status) {
      case _CargoStatus.inInspection:
        return AppColors.statusPending;
      case _CargoStatus.shipped:
        return AppColors.statusApproved;
      case _CargoStatus.preparing:
        return const Color(0xFF2F80ED);
      case _CargoStatus.hold:
        return AppColors.statusBlocked;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: cargo.iconBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(cargo.icon, size: 20, color: cargo.iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cargo.id,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      cargo.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.sectionLabel,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: statusColor.withOpacity(0.4)),
                ),
                child: Text(
                  _statusLabel,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.innerFill,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppColors.iconMuted,
                    ),
                    const SizedBox(width: 4),
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.iconMuted,
                        ),
                        children: [
                          const TextSpan(text: 'Hedef: '),
                          TextSpan(
                            text: cargo.destination,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.inventory_2_outlined,
                      size: 14,
                      color: AppColors.iconMuted,
                    ),
                    const SizedBox(width: 4),
                    Text.rich(
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.iconMuted,
                        ),
                        children: [
                          const TextSpan(text: 'Rampa: '),
                          TextSpan(
                            text: cargo.ramp,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (cargo.extraValue.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: cargo.extraHighlighted
                          ? AppColors.statusApproved.withOpacity(0.12)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: cargo.extraHighlighted
                            ? AppColors.statusApproved.withOpacity(0.4)
                            : AppColors.cardBorder,
                      ),
                    ),
                    child: Text(
                      cargo.extraLabel.isEmpty
                          ? cargo.extraValue
                          : '${cargo.extraLabel} ${cargo.extraValue}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                        color: cargo.extraHighlighted
                            ? AppColors.statusApproved
                            : AppColors.sectionLabel,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              for (final step in cargo.steps)
                Expanded(
                  child: Text(
                    step.label,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: step.state == _StepState.upcoming
                          ? AppColors.sectionLabel
                          : AppColors.primaryTeal,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              for (int i = 0; i < cargo.steps.length; i++) ...[
                Expanded(
                  child: Container(
                    height: 5,
                    decoration: BoxDecoration(
                      color: _barColor(cargo.steps[i].state),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                if (i != cargo.steps.length - 1) const SizedBox(width: 4),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Color _barColor(_StepState state) {
    switch (state) {
      case _StepState.done:
        return AppColors.primaryTeal;
      case _StepState.active:
        return AppColors.primaryTeal.withOpacity(0.45);
      case _StepState.upcoming:
        return AppColors.cardBorder;
    }
  }
}
