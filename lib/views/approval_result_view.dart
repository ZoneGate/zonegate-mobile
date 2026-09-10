import 'package:flutter/material.dart';
import '../models/policy_decision.dart';
import '../theme/app_colors.dart';
import 'receipt_detail_view.dart';

class ApprovalCheck {
  final String label;
  final String value;
  const ApprovalCheck({required this.label, required this.value});
}

/// Instant, lightweight confirmation shown the moment a request is
/// approved — separate from ReceiptDetailView, which is the fuller
/// record someone opens later from the Requests log.
class ApprovalResultView extends StatelessWidget {
  final String authorizationRef;
  final List<ApprovalCheck> checks;
  final String policy;
  final String source;

  /// Decision this result belongs to, so the full record can be opened.
  final String decisionId;

  const ApprovalResultView({
    super.key,
    required this.authorizationRef,
    required this.checks,
    required this.policy,
    required this.source,
    required this.decisionId,
  });

  /// Builds the confirmation from what the policy engine actually returned.
  ///
  /// The checks are the canonical evidence the Gateway collected, not a
  /// hard-coded list: an item the planner never requested shows as
  /// NOT COLLECTED rather than silently reading as a pass.
  factory ApprovalResultView.fromDecision(PolicyDecision decision) {
    String state(bool? value, {bool invert = false}) {
      if (value == null) return 'NOT COLLECTED';
      final good = invert ? !value : value;
      return good ? 'VERIFIED' : 'FAILED';
    }

    final evidence = decision.evidenceSummary;

    return ApprovalResultView(
      authorizationRef: decision.transactionId,
      decisionId: decision.decisionId,
      policy: decision.reasons.isEmpty ? 'DETERMINISTIC POLICY' : decision.reasons.first,
      source: decision.resolution == null ? 'AUTOMATIC' : 'AUTHORIZED HUMAN',
      checks: [
        ApprovalCheck(
          label: 'Registered Number Match',
          value: state(evidence?.numberVerified),
        ),
        ApprovalCheck(
          label: 'Expected Device in Zone',
          value: state(evidence?.locationVerified),
        ),
        ApprovalCheck(
          label: 'SIM Continuity',
          value: state(evidence?.recentSimSwap, invert: true),
        ),
        ApprovalCheck(
          label: 'Device Continuity',
          value: state(evidence?.recentDeviceSwap, invert: true),
        ),
        ApprovalCheck(
          label: 'Reachability',
          value: state(evidence?.reachable),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(flex: 3),
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.statusApproved.withValues(alpha: 0.10),
                ),
                child: Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.statusApproved,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.statusApproved.withValues(alpha: 0.5),
                  ),
                ),
                child: const Text(
                  'APPROVED',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.statusApproved,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.innerFill,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Column(
                  children: [
                    for (final check in checks) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              check.label,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              check.value,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryTeal,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (check != checks.last)
                        const Divider(height: 1, color: AppColors.cardBorder),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // A real policy reason is a full sentence, not a short code, so
              // these stack and wrap instead of sitting side by side.
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MetaLine(label: 'Policy', value: policy),
                  const SizedBox(height: 6),
                  _MetaLine(label: 'Source', value: source),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) =>
                            ReceiptDetailView(decisionId: decisionId),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryTeal,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'VIEW RECEIPT',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}

/// One `label: value` line under the checks, wrapping across as many lines as
/// the value needs.
class _MetaLine extends StatelessWidget {
  final String label;
  final String value;

  const _MetaLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 12,
          height: 1.4,
          color: AppColors.sectionLabel,
          fontFamily: 'monospace',
        ),
        children: [
          TextSpan(text: '$label: '),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
