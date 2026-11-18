# Development Orchestration Contract

This contract describes how Copilot agents coordinate software-development work in this repository. It is process guidance, not an executable GitHub Actions workflow or a security boundary; prompts and tool allowlists do not prove that the host enforces a model, tool, or approval gate.

## Ownership and assignment

- One orchestrator owns the task breakdown, dependency graph, human communication, integration, and task ledger.
- The orchestrator is the sole assignment authority and assigns each bounded task directly to one agent instance. Every other agent instance—implementation, QA, or reviewer—owns one task and is retired when it finishes; it does not delegate, invoke another agent, or take follow-on work. New or follow-on work returns to the orchestrator for a distinct task ID and fresh assignment.
- Keep an active-assignment ledger with task ID, owner, stage, dependencies, scope, status, deliverable revision, checks, review/QA verdicts, approvals, commit hash, blockers, and next action.
- Never assign the same task to multiple active agents. Parallelize only independent, dependency-ready work within the currently approved stage. Use map/reduce only when distinct tasks and explicit inputs/outputs make it useful; a serial path is preferred when coordination would not help.
- Limit active agent instances to eight total across roles and workstreams. Eight is a hard ceiling, not a target; block or defer any assignment that would exceed it, including a ninth instance. Use a lower soft limit when resources or coordination overhead warrant it. Check the ledger before each assignment.
- Honor the human's model and effort direction. If a specifically required model, reviewer, or direct-assignment capability is unavailable, mark the task BLOCKED and ask for direction rather than silently substituting or introducing nested delegation. State when runtime settings cannot be verified.
- No QA agent or reviewer may assess work it authored. For code and test changes, the QA and code-review assignments are separate; if an independent check is unavailable, mark the gate BLOCKED.

Each assignment states the role, task ID, stage, owner, goal, approved inputs, allowed files/worktree, dependencies, acceptance criteria, focused checks, prohibited actions, integration/commit owner, and return format. The return includes a summary, changed files, commands and results, commit IDs or uncommitted status, evidence, blockers, risks, and a recommended next action.

## Stage gates

For non-trivial implementation work, use these stages in order:

1. **Research:** establish the goal or reproduction, local evidence, affected ownership, constraints, uncertainties, and risks.
2. **Plan:** define bounded tasks, file ownership, dependencies, acceptance criteria, integration order, and rollback.
3. **Test Plan:** specify acceptance criteria, cases and scenarios, inputs and expected results, environment, setup/teardown, focused commands, regression scope, negative cases, and useful compact mock/fixture data. If fixtures are unnecessary, explain why. Do not implement tests at this stage.
4. **Implement Tests:** add tests from the approved specification and establish the relevant baseline. For behavior changes, show that tests detect the intended failure; for behavior-preserving work, explain why a green baseline is appropriate.
5. **Implement Changes:** make small scoped changes, run the agreed focused checks, and record commit evidence.
6. **Code Review:** obtain independent review, resolve or explicitly report findings, and verify regression coverage and residual risks.

At each stage, provide its deliverable and evidence, obtain an independent QA verdict, then ask the human to approve that exact revision before advancing. Report PASS, FAIL, or BLOCKED; missing evidence is BLOCKED, never an assumed pass. A scope or acceptance-criteria change reopens the earliest affected stage and invalidates dependent approvals. Scale the depth of each deliverable to the task, but do not silently skip a gate; record a reasoned not-applicable result and have QA verify it.

### Visual work

- During Research, classify whether layout, typography, color, imagery, animation, responsive behavior, or visible interaction states change. QA verifies any not-applicable determination.
- For visual changes, have an independent design reviewer evaluate proposed screens and affected states before Plan approval. QA verifies the exact artifacts and criteria coverage.
- After implementation, the reviewer evaluates the actual rendered output and interactions for the exact revision at agreed desktop/mobile viewports and relevant states. QA verifies artifact identity and criteria coverage, and the human accepts the result before Code Review. Source inspection or functional tests alone are not visual evidence; unavailable evidence blocks advancement.
- A nonvisual task records a QA-verified not-applicable result.

## Iteration and stop-the-line

- A failed sketch, rejected approach, expected-red test, or unsuccessful focused attempt before its gate is ordinary iteration. Record it, update the diagnosis, and continue within the approved scope. A failure at the current gate blocks only the affected task; repair may continue there, and independent work may proceed.
- Allow up to three consecutive focused fix-and-check attempts on the same unresolved issue. After the third unsuccessful attempt—or sooner if the issue exceeds scope or authority—escalate to the orchestrator, report attempts and evidence, and stop that affected work line until the human authorizes the next action. Do not start a fourth attempt without authorization.
- Use the Andon/stop-the-line response when a defect is found in work that already passed an applicable review, QA, or human-approval gate: stop affected downstream work, report the escaped defect and affected revisions, reopen the relevant gate, and invalidate dependent approvals. Stop unrelated work only when the defect is systemic or blocks it.
- A current-gate rejection is not an escaped defect. Do not mislabel normal iteration as stop-the-line, and do not let an escaped defect proceed downstream.
- If requirements become too ambiguous to proceed within the approved criteria, pause the affected line, preserve state and evidence, and ask the human which stage to reopen.

## Reviews, commits, and pushes

- Break implementation into coherent, independently reviewable semantic changes. Run the agreed focused check and inspect the complete diff after each change. Code and test changes receive independent code review; other deliverables receive QA review. QA verifies scope, evidence, and required review before the next change begins.
- Prefer the narrowest checks that provide useful evidence; run broader suites at agreed integration or acceptance points, not reflexively after every edit.
- The assigned implementation owner commits cleared work unless the assignment names a single integration/commit owner. Other agents return evidence rather than staging or committing.
- Before each commit, stage only the cleared change and inspect the staged diff. Obtain review and QA on the exact staged content; if it changes, repeat those checks. Commit only after PASS.
- After a commit, give QA its hash. QA verifies the commit diff against the cleared staged content before further work. Keep commits small, descriptive, and attributable to their task owner. Never rewrite pushed history.
- Every push requires fresh, explicit human approval naming the remote, destination branch, and exact commit or range. A preference for early pushes is not standing authorization. Do not push while approval is absent or ambiguous.
- Use isolated worktrees/build directories for parallel writers or incompatible build targets. Preserve unrelated work and avoid destructive Git operations without explicit permission.

## Cloud, network, and resources

- Prefer approved cloud agents for eligible independent tasks when available. Keep local-only runtime, browser/device, or hardware checks in an environment that can access them. Transfer only the required task context, diffs, and compact test artifacts; never send secrets to unapproved services. Do not claim a delegation ran unless it did.
- During ordinary network slowness, avoid redundant requests and transfers. When a network interruption is detected, pause local and cloud task work at a safe checkpoint and preserve state. Resume only after passive recovery is evident, a necessary ordinary operation succeeds, or the human confirms recovery. Do not generate traffic solely to test connectivity.
- Before heavy local work, check observable CPU, memory, and disk headroom; treat stated machine capacity as total, not free capacity. Cap CPU-heavy concurrency at four cores and reduce it when resources are constrained. If resource data is unavailable, state that and schedule conservatively.
- When several tasks will obviously compile or build concurrently, stagger starts when practical to reduce I/O contention. This is a soft preference, not strict serialization; overlap is acceptable when delay costs more than the expected contention.
- Keep task-specific temporary state under `/tmp/copilot/<task-id>/` and clean up only task-owned files. Do not include secrets or unnecessary sensitive data in fixtures or artifacts.

## Handoff

Before finishing, report completed work, exact revisions and commits, validation and review results, coverage gaps, unresolved risks, and any remaining task-owned processes or artifacts. Distinguish repository-declared policy from host-enforced behavior.

<!-- Co-authored by GitHub Copilot. Scope: repository development-orchestration contract and Copilot activation instructions. Model and reasoning effort unavailable. Partial task wall time: 6m18s (2026-11-18 22:47:55.781–22:54:14 UTC; excludes follow-up review, commit, CodeQL, and final verification). One read-only review subagent completed two passes in 2m53s total (1m34s + 1m19s; overlapping with task wall time). Energy (kWh) and CO2: unavailable; no measured data or defensible estimation inputs. -->
