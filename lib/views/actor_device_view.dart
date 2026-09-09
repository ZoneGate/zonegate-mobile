import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/app_top_bar.dart';
import 'cargos_view.dart';
import 'home_view.dart';
import 'requests_view.dart';

/// Shown when the operator taps their profile avatar. Displays how
/// their enterprise identity (Actor) is bound to this enrolled
/// device — network evidence is always checked against this binding.
class ActorDeviceView extends StatelessWidget {
  final String enrollmentStatus;
  final String validFrom;
  final String actorId;
  final String registeredPhone;
  final String deviceReference;

  const ActorDeviceView({
    super.key,
    this.enrollmentStatus = 'ACTIVE',
    this.validFrom = '2023-10-01',
    this.actorId = 'EMP-204',
    this.registeredPhone = '+966••••217',
    this.deviceReference = 'DEV-17',
  });

  void _onTabSelected(BuildContext context, AppTab tab) {
    final builder = switch (tab) {
      AppTab.home => (BuildContext _) => const HomeView(),
      AppTab.requests => (BuildContext _) => const RequestsView(),
      AppTab.cargos => (BuildContext _) => const CargosView(),
    };
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: builder));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const AppTopBar(),
            const Divider(height: 1, color: AppColors.cardBorder),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.devices_other_rounded,
                        size: 14,
                        color: AppColors.primaryTeal,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'DEVICE BINDING',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryTeal,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Actor-Device Enrollment',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'ZoneGate binds your enterprise identity to this enrolled device. Network evidence is always checked against this binding.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.sectionLabel,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.statusApproved.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.statusApproved.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.statusApproved.withOpacity(0.14),
                          ),
                          child: Icon(
                            Icons.verified_user_rounded,
                            color: AppColors.statusApproved,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'ENROLLMENT STATUS',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.sectionLabel,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Container(
                                    width: 7,
                                    height: 7,
                                    margin: const EdgeInsets.only(right: 6),
                                    decoration: const BoxDecoration(
                                      color: AppColors.statusApproved,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Text(
                                    enrollmentStatus,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.statusApproved,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'VALID FROM',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.sectionLabel,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                validFrom,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.innerFill,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.badge_outlined,
                              size: 15,
                              color: AppColors.primaryTeal,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'ACTOR IDENTITY',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.sectionLabel,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(height: 1, color: AppColors.cardBorder),
                        const SizedBox(height: 14),
                        _FieldBox(label: 'Actor ID', value: actorId),
                        const SizedBox(height: 14),
                        _FieldBox(
                          label: 'Registered Phone',
                          value: registeredPhone,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.innerFill,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.cardBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.memory_rounded,
                              size: 15,
                              color: AppColors.primaryTeal,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'HARDWARE REF',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.sectionLabel,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(height: 1, color: AppColors.cardBorder),
                        const SizedBox(height: 14),
                        _FieldBox(
                          label: 'Device Reference',
                          value: deviceReference,
                          icon: Icons.developer_board_rounded,
                        ),
                        const SizedBox(height: 20),
                        const _BindingDiagram(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        size: 14,
                        color: AppColors.primaryTeal,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Identity verification managed by Enterprise Policy.',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.sectionLabel,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentTab: null,
        onTabSelected: (tab) => _onTabSelected(context, tab),
      ),
    );
  }
}

class _FieldBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;

  const _FieldBox({required this.label, required this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 15, color: AppColors.primaryTeal),
                const SizedBox(width: 8),
              ],
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Small visual: actor — link — device, showing the binding at a glance.
class _BindingDiagram extends StatelessWidget {
  const _BindingDiagram();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _nodeIcon(Icons.person_outline_rounded, filled: false),
        Expanded(child: _connectorLine()),
        _nodeIcon(Icons.link_rounded, filled: true),
        Expanded(child: _connectorLine()),
        _nodeIcon(Icons.smartphone_rounded, filled: false),
      ],
    );
  }

  Widget _nodeIcon(IconData icon, {required bool filled}) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: filled
            ? AppColors.statusApproved.withOpacity(0.12)
            : Colors.white,
        border: Border.all(
          color: filled
              ? AppColors.statusApproved.withOpacity(0.5)
              : AppColors.cardBorder,
        ),
      ),
      child: Icon(
        icon,
        size: 16,
        color: filled ? AppColors.statusApproved : AppColors.iconMuted,
      ),
    );
  }

  Widget _connectorLine() {
    return Container(
      height: 2,
      color: AppColors.statusApproved.withOpacity(0.3),
    );
  }
}
