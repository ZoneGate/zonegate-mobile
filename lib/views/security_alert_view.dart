import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Full-screen security alert shown when the system detects something
/// like a presence attack, a stolen-account attempt, or a login from
/// an unexpected second device.
class SecurityAlertView extends StatelessWidget {
  final String badgeLabel;
  final String title;
  final String reasonCode;
  final String diagnosticLabel;
  final String diagnosticValue;
  final String requiredZoneNote;
  final String requiredZoneCode;

  const SecurityAlertView({
    super.key,
    required this.badgeLabel,
    required this.title,
    required this.reasonCode,
    required this.diagnosticLabel,
    required this.diagnosticValue,
    required this.requiredZoneNote,
    required this.requiredZoneCode,
  });

  factory SecurityAlertView.demoPresenceAttack() {
    return const SecurityAlertView(
      badgeLabel: 'BLOCKED',
      title: 'Presence Attack Detected',
      reasonCode: 'ACCOUNT AUTH VALID — NETWORK LOCATION EVIDENCE INVALID',
      diagnosticLabel: 'Registered device in handoff zone:',
      diagnosticValue: 'NOT VERIFIED',
      requiredZoneNote:
          'This action requires the enrolled device to be present at',
      requiredZoneCode: 'PORT_GATE_17',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 36, 24, 28),
              decoration: const BoxDecoration(color: Color(0xFFFCEBEB)),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.statusBlocked.withOpacity(0.12),
                    ),
                    child: Icon(
                      Icons.warning_rounded,
                      color: AppColors.statusBlocked,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.statusBlocked,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      badgeLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.innerFill,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.code_rounded,
                              size: 15,
                              color: AppColors.statusBlocked,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'REASON CODE',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.sectionLabel,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          reasonCode,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.statusBlocked,
                            fontFamily: 'monospace',
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'DIAGNOSTIC EVIDENCE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.sectionLabel,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.podcasts_rounded,
                        size: 18,
                        color: AppColors.iconMuted,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          diagnosticLabel,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Text(
                        diagnosticValue,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: AppColors.statusBlocked,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1, color: AppColors.cardBorder),
                  const SizedBox(height: 22),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.innerFill,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          size: 18,
                          color: AppColors.primaryTeal,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                '$requiredZoneNote ',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                  height: 1.4,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: AppColors.primaryTeal.withOpacity(
                                      0.4,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  requiredZoneCode,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'monospace',
                                    color: AppColors.primaryTeal,
                                  ),
                                ),
                              ),
                              const Text(
                                '.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.cardBorder),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Dismiss',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
