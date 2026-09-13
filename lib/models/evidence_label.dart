/// What an evidence badge says, including when the carrier gave no answer.
///
/// An empty reading has three different causes, and they mean different
/// things to the person reading the record:
///
/// - the plan never asked for the check (the agent judged it unnecessary);
/// - number verification, which the workflow requires but this deployment's
///   carrier cannot attest at all, so the validator dropped it from the plan
///   and the decision carries a caveat;
/// - a check that was on the plan and the carrier did not answer, which is the
///   only case that is genuinely "not collected".
///
/// `planned` is the plan's combined evidence. An empty list means no plan was
/// recorded, and then nothing is guessed. Matches the web console.
String evidenceLabel(String kind, bool? state, List<String> planned) {
  if (state != null) return state ? 'TRUE' : 'FALSE';
  if (planned.isEmpty || planned.contains(kind)) return 'NOT COLLECTED';
  if (kind == 'NUMBER_VERIFICATION') return 'CARRIER CANNOT ATTEST';
  return 'NOT REQUESTED';
}
