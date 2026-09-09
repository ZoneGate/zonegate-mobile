import 'package:flutter/material.dart';
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

  const ApprovalResultView({
    super.key,
    required this.authorizationRef,
    required this.checks,
    required this.policy,
    required this.source,
  });

  // TODO: replace with the real live result payload once the backend
  // can push an approval event (e.g. after POST /v1/authorizations
  // returns decision == APPROVE). Not testable yet — UI shell only.
  factory ApprovalResultView.demoFor(String authorizationRef) {
    return ApprovalResultView(
      authorizationRef: authorizationRef,
      policy: 'CARGO_RELEASE_V3',
      source: 'AUTOMATIC',
      checks: const [
        ApprovalCheck(label: 'Registered Number Match', value: 'VERIFIED'),
        ApprovalCheck(label: 'Expected Device in Zone', value: 'VERIFIED'),
        ApprovalCheck(label: 'Device Continuity', value: 'PASS'),
        ApprovalCheck(label: 'Reachability', value: 'PASS'),
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
                  color: AppColors.statusApproved.withOpacity(0.10),
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
                    color: AppColors.statusApproved.withOpacity(0.5),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.sectionLabel,
                        fontFamily: 'monospace',
                      ),
                      children: [
                        const TextSpan(text: 'Policy: '),
                        TextSpan(
                          text: policy,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.sectionLabel,
                        fontFamily: 'monospace',
                      ),
                      children: [
                        const TextSpan(text: 'Source: '),
                        TextSpan(
                          text: source,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                            ReceiptDetailView.demoSuccessFor(authorizationRef),
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
