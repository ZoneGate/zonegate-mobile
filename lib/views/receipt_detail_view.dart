import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/status_badge.dart';

enum ReceiptResult { success, rejected, hold }

class EvidenceRow {
  final String number;
  final String location;
  final String continuity;
  final String reachability;

  const EvidenceRow({
    required this.number,
    required this.location,
    required this.continuity,
    required this.reachability,
  });
}

/// Full receipt for one authorization — success, rejected, and hold
/// share this same screen, only the result-driven fields differ.
class ReceiptDetailView extends StatelessWidget {
  final String receiptId;
  final ReceiptResult result;
  final String authorizationRef;
  final String timestamp;
  final String policyApplied;
  final String decisionSource;
  final String? rejectionReason;
  final String? holdReason;
  final String? supervisorNote;
  final String evaluatedByLabel;
  final String evaluatedBy;
  final List<EvidenceRow> evidence;

  const ReceiptDetailView({
    super.key,
    required this.receiptId,
    required this.result,
    required this.authorizationRef,
    required this.timestamp,
    required this.policyApplied,
    required this.decisionSource,
    required this.evaluatedByLabel,
    required this.evaluatedBy,
    required this.evidence,
    this.rejectionReason,
    this.holdReason,
    this.supervisorNote,
  });

  // TODO: replace these factories with a real receipt lookup once the
  // backend exposes an endpoint. For now they build plausible demo
  // data from the tapped authorization's id.
  factory ReceiptDetailView.demoSuccessFor(String authorizationRef) {
    final numericPart = authorizationRef.split('-').last;
    return ReceiptDetailView(
      receiptId: 'ZG-RCP-$numericPart',
      result: ReceiptResult.success,
      authorizationRef: authorizationRef,
      timestamp: '2023-11-24 14:22:11 UTC',
      policyApplied: 'CARGO_RELEASE_V3',
      decisionSource: 'AUTHORIZED_HUMAN',
      evaluatedByLabel: 'APPROVED BY',
      evaluatedBy: 'SUP-902 (Port Supervisor)',
      evidence: const [
        EvidenceRow(
          number: 'EV-001',
          location: 'Node-Alpha',
          continuity: 'Verified',
          reachability: 'Direct',
        ),
        EvidenceRow(
          number: 'EV-002',
          location: 'Gateway-7',
          continuity: 'Verified',
          reachability: 'Routed',
        ),
        EvidenceRow(
          number: 'EV-003',
          location: 'Term-B',
          continuity: 'Verified',
          reachability: 'Direct',
        ),
        EvidenceRow(
          number: 'EV-004',
          location: 'Auth-Server',
          continuity: 'Verified',
          reachability: 'Direct',
        ),
      ],
    );
  }

  factory ReceiptDetailView.demoRejectedFor(String authorizationRef) {
    final numericPart = authorizationRef.split('-').last;
    return ReceiptDetailView(
      receiptId: 'ZG-RCP-$numericPart',
      result: ReceiptResult.rejected,
      authorizationRef: authorizationRef,
      timestamp: '2023-11-24 14:22:11 UTC',
      policyApplied: 'CARGO_RELEASE_V3',
      decisionSource: 'SECURITY_GATEWAY',
      rejectionReason: 'TOKEN_ALREADY_CONSUMED',
      evaluatedByLabel: 'EVALUATED BY',
      evaluatedBy: 'SUP-902 (Port Supervisor)',
      evidence: const [
        EvidenceRow(
          number: 'EV-001',
          location: 'Node-Alpha',
          continuity: 'Failed',
          reachability: 'Direct',
        ),
        EvidenceRow(
          number: 'EV-002',
          location: 'Gateway-7',
          continuity: 'Blocked',
          reachability: 'Routed',
        ),
        EvidenceRow(
          number: 'EV-003',
          location: 'Term-B',
          continuity: 'Unverified',
          reachability: 'Direct',
        ),
        EvidenceRow(
          number: 'EV-004',
          location: 'Auth-Server',
          continuity: 'Mismatch',
          reachability: 'Direct',
        ),
      ],
    );
  }

  factory ReceiptDetailView.demoHoldFor(String authorizationRef) {
    final numericPart = authorizationRef.split('-').last;
    return ReceiptDetailView(
      receiptId: 'ZG-RCP-$numericPart',
      result: ReceiptResult.hold,
      authorizationRef: authorizationRef,
      timestamp: '2023-11-24 14:22:11 UTC',
      policyApplied: 'CARGO_RELEASE_V3 (SECURITY_HOLD)',
      decisionSource: 'AUTOMATED_QUARANTINE',
      holdReason:
          'Sensor variance detected at Gate 4B cargo container scanner. Continuity audit required before physical gate clearance.',
      evaluatedByLabel: 'ASSIGNED SUPERVISOR',
      evaluatedBy: 'SUP-902 (Port Supervisor)',
      supervisorNote: 'Pending Decision',
      evidence: const [
        EvidenceRow(
          number: 'EV-001',
          location: 'Node-Alpha',
          continuity: 'Verified',
          reachability: 'Direct',
        ),
        EvidenceRow(
          number: 'EV-002',
          location: 'Gateway-7',
          continuity: 'Verified',
          reachability: 'Routed',
        ),
        EvidenceRow(
          number: 'EV-003',
          location: 'Term-B',
          continuity: 'Under Audit',
          reachability: 'Direct',
        ),
        EvidenceRow(
          number: 'EV-004',
          location: 'Auth-Server',
          continuity: 'Unsynced',
          reachability: 'Direct',
        ),
      ],
    );
  }

  Color get _resultColor {
    switch (result) {
      case ReceiptResult.success:
        return AppColors.statusApproved;
      case ReceiptResult.rejected:
        return AppColors.statusBlocked;
      case ReceiptResult.hold:
        return AppColors.statusPending;
    }
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
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          size: 20,
                          color: Colors.black87,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Receipt Detail',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 34),
                    child: Row(
                      children: [
                        Text(
                          'ID: $receiptId',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.sectionLabel,
                            fontFamily: 'monospace',
                          ),
                        ),
                        if (result == ReceiptResult.hold) ...[
                          const SizedBox(width: 6),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: _resultColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  _ExecutionResultCard(result: result, color: _resultColor),
                  const SizedBox(height: 16),
                  _InfoCard(
                    result: result,
                    authorizationRef: authorizationRef,
                    authRefColor: _resultColor,
                    timestamp: timestamp,
                    policyApplied: policyApplied,
                    decisionSource: decisionSource,
                    rejectionReason: rejectionReason,
                    holdReason: holdReason,
                    supervisorNote: supervisorNote,
                    evaluatedByLabel: evaluatedByLabel,
                    evaluatedBy: evaluatedBy,
                  ),
                  const SizedBox(height: 16),
                  _EvidenceSummaryCard(evidence: evidence, result: result),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExecutionResultCard extends StatelessWidget {
  final ReceiptResult result;
  final Color color;
  const _ExecutionResultCard({required this.result, required this.color});

  @override
  Widget build(BuildContext context) {
    final isHold = result == ReceiptResult.hold;
    final isRejected = result == ReceiptResult.rejected;
    final icon = isHold
        ? Icons.pending_actions_outlined
        : (isRejected ? Icons.close_rounded : Icons.check_rounded);
    final label = isHold ? 'EXECUTION STATUS' : 'EXECUTION RESULT';
    final resultText = isHold
        ? 'SUPERVISOR HOLD'
        : (isRejected ? 'REJECTED' : 'SUCCESS');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        color: AppColors.innerFill,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.10),
              border: Border.all(color: color.withOpacity(0.4)),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 14),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.sectionLabel,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            resultText,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final ReceiptResult result;
  final String authorizationRef;
  final Color authRefColor;
  final String timestamp;
  final String policyApplied;
  final String decisionSource;
  final String? rejectionReason;
  final String? holdReason;
  final String? supervisorNote;
  final String evaluatedByLabel;
  final String evaluatedBy;

  const _InfoCard({
    required this.result,
    required this.authorizationRef,
    required this.authRefColor,
    required this.timestamp,
    required this.policyApplied,
    required this.decisionSource,
    required this.evaluatedByLabel,
    required this.evaluatedBy,
    this.rejectionReason,
    this.holdReason,
    this.supervisorNote,
  });

  @override
  Widget build(BuildContext context) {
    final isHold = result == ReceiptResult.hold;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.innerFill,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        children: [
          _InfoRow(label: 'TIMESTAMP', value: timestamp, monospace: true),
          const Divider(height: 1, color: AppColors.cardBorder),
          _InfoRow(
            label: 'AUTHORIZATION REF',
            value: authorizationRef,
            monospace: true,
            valueColor: authRefColor,
          ),
          const Divider(height: 1, color: AppColors.cardBorder),
          _InfoRow(
            label: 'POLICY APPLIED',
            value: policyApplied,
            monospace: true,
          ),
          const Divider(height: 1, color: AppColors.cardBorder),
          _InfoRow(
            label: 'DECISION SOURCE',
            value: decisionSource,
            monospace: true,
          ),
          if (rejectionReason != null) ...[
            const Divider(height: 1, color: AppColors.cardBorder),
            _InfoRow(
              label: 'REJECTION REASON',
              value: rejectionReason!,
              monospace: true,
              valueColor: AppColors.statusBlocked,
            ),
          ],
          const Divider(height: 1, color: AppColors.cardBorder),
          isHold
              ? _SupervisorRow(
                  label: evaluatedByLabel,
                  value: evaluatedBy,
                  note: supervisorNote,
                  noteColor: authRefColor,
                  isLast: holdReason == null,
                )
              : _InfoRow(
                  label: evaluatedByLabel,
                  value: evaluatedBy,
                  icon: Icons.badge_outlined,
                  isLast: true,
                ),
          if (holdReason != null) ...[
            const Divider(height: 1, color: AppColors.cardBorder),
            _HoldReasonBlock(reason: holdReason!, color: authRefColor),
          ],
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool monospace;
  final Color? valueColor;
  final IconData? icon;
  final bool isLast;

  const _InfoRow({
    required this.label,
    required this.value,
    this.monospace = false,
    this.valueColor,
    this.icon,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 14, bottom: isLast ? 14 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.sectionLabel,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 15,
                  color: valueColor ?? AppColors.primaryTeal,
                ),
                const SizedBox(width: 6),
              ],
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontFamily: monospace ? 'monospace' : null,
                    color: valueColor ?? Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Like _InfoRow, but the value is split into a neutral part and a
/// colored trailing note (e.g. "SUP-902 (Port Supervisor) - Pending Decision").
class _SupervisorRow extends StatelessWidget {
  final String label;
  final String value;
  final String? note;
  final Color noteColor;
  final bool isLast;

  const _SupervisorRow({
    required this.label,
    required this.value,
    required this.noteColor,
    this.note,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 14, bottom: isLast ? 14 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.sectionLabel,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.hourglass_bottom_rounded, size: 15, color: noteColor),
              const SizedBox(width: 6),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(text: value),
                      if (note != null) ...[
                        const TextSpan(text: ' - '),
                        TextSpan(
                          text: note,
                          style: TextStyle(color: noteColor),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HoldReasonBlock extends StatelessWidget {
  final String reason;
  final Color color;
  const _HoldReasonBlock({required this.reason, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'HOLD REASON',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.sectionLabel,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color.withOpacity(0.35)),
            ),
            child: Text(
              reason,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EvidenceSummaryCard extends StatelessWidget {
  final List<EvidenceRow> evidence;
  final ReceiptResult result;
  const _EvidenceSummaryCard({required this.evidence, required this.result});

  StatusTone _toneFor(String continuity) {
    switch (continuity.toLowerCase()) {
      case 'verified':
        return StatusTone.positive;
      case 'unverified':
        return StatusTone.neutral;
      case 'under audit':
      case 'unsynced':
        return StatusTone.pending;
      default:
        return StatusTone.negative;
    }
  }

  @override
  Widget build(BuildContext context) {
    // The evidence icon reflects the network's own findings, not the
    // overall receipt outcome — a hold can still have mostly-verified
    // evidence, so it keeps the neutral/teal "verified" look.
    final isRejected = result == ReceiptResult.rejected;
    final headerColor = isRejected
        ? AppColors.statusBlocked
        : AppColors.primaryTeal;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.innerFill,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isRejected
                    ? Icons.gpp_bad_outlined
                    : Icons.verified_user_outlined,
                size: 18,
                color: headerColor,
              ),
              const SizedBox(width: 8),
              const Text(
                'Evidence Summary',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: const [
              Expanded(flex: 2, child: _HeaderCell('NUMBER')),
              Expanded(flex: 3, child: _HeaderCell('LOCATION')),
              Expanded(flex: 3, child: _HeaderCell('CONTINUITY')),
              Expanded(flex: 2, child: _HeaderCell('REACHABILITY')),
            ],
          ),
          const SizedBox(height: 10),
          for (final row in evidence) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      row.number,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      row.location,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: StatusBadge(
                        label: row.continuity,
                        tone: _toneFor(row.continuity),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      row.reachability,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.sectionLabel,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (row != evidence.last)
              const Divider(height: 1, color: AppColors.cardBorder),
          ],
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;
  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 9,
        fontWeight: FontWeight.w700,
        color: AppColors.sectionLabel,
        letterSpacing: 0.3,
      ),
    );
  }
}
