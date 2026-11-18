# Research Findings: Orchestration Policy Dry-Run Sample

**Status:** Partial  
**Researched:** 2026-11-18 (UTC)  
**Question:** What minimum scope decisions must Plan resolve before a temporary Markdown example can serve as the sample for an orchestration-policy dry-run?  
**Scope and assumptions:** Evidence about behavior comes from the task assignment, the named orchestration plan, and the shared contract. The selected sample category is a temporary, docs-only Markdown example under `/tmp/copilot/development-orchestration-dryrun-20261118/`; its text and target behavior are not approved. No sample or policy scenario was created or run. No application code, tests, builds, or unrelated worktree state were inspected. Visual impact is expected to be not applicable because the selected scope has no layout or UI changes.

## Key Findings

- [E1] The plan's P4 dry-run depends on P1-P3 and a human-selected task, and lists six-stage gates, QA and human approvals, expected-red and retry/escalation paths, hard/soft limits, and local-only checkpoints. A single unspecified Markdown example cannot be assumed to cover that scope.
- [E2] The contract requires sequential stages and an independent QA verdict plus an explicit human checkpoint at each stage. The task assignment also says the sample-category selection is not approval of this Research deliverable; no approval is inferred here.
- [E3] The assignment reports 5/8 active instances, including four earlier instances whose retirement is unverified. If accurate, this leaves three places under the contract's hard cap; the count was not independently verified, and no agent was launched.
- [E4] Visual impact is expected N/A for the selected docs-only sample. Reassessment would be needed if it later changes a rendered UI or user-facing layout.

## Evidence Ledger

| ID | Finding | Type | Confidence and basis | Source and date | Planning relevance |
| --- | --- | --- | --- | --- | --- |
| E1 | P4 depends on P1-P3 and a selected sample, and names multiple scenarios beyond a single content example. | documented fact | High; stated in the P4 row and dry-run checklist. | [Plan](../plans/development-orchestration-workflow.md), dated 2026-11-17; read 2026-11-18. | Plan must decide whether the sample is a narrow vignette or represents broader P4 coverage. |
| E2 | Each stage requires QA and explicit human approval; the contract does not treat an initial request as approval. | documented fact | High; explicit in Stage Gates. | [Shared contract](../../.github/workflows/development-orchestration.md), date not stated; read 2026-11-18. | The dry-run record must distinguish simulated checkpoints from actual verdicts or approvals. |
| E3 | Current tracked count is reported as 5/8; four earlier retirements are unverified. | documented fact | Medium; directly stated in the assignment but not checked against an independent ledger. | Task assignment DRYRUN-20261118-R1, 2026-11-18. | Do not use the reported count as verified live state or create further assignments from this research task. |
| E4 | The requested sample directory resolves beneath `/tmp/copilot`; the directory exists and its requested `research.md` target was absent at check time. | direct observation | High; read-only path and existence checks returned those results. | Local path check, 2026-11-18 UTC. | Confirms the selected temporary location, not the content or behavior of a future sample. |
| E5 | A Markdown vignette can demonstrate one policy decision but cannot establish full P4 coverage unless it records the other listed cases. | inference | High; follows from P4's enumerated scope and the sample's unspecified content. | E1 plus task assignment, 2026-11-18. | Keep sample coverage claims proportional to what it actually records. |
| E6 | No layout, styling, imagery, animation, responsive behavior, or visible interaction state is in the selected sample scope. | assumption | High for the stated docs-only scope; not evidence about any later integration. | Task assignment, 2026-11-18; [Plan](../plans/development-orchestration-workflow.md), “Implementation and Acceptance.” | Record visual impact as N/A unless the scope changes. |

## Options and Trade-offs

- A focused Markdown vignette could document one named policy branch with low content overhead, but would not alone demonstrate the full P4 scenario list.
- A Markdown scenario record could cover more P4 cases, but would be larger and would still show procedural decisions only, not host-enforced model/tool restrictions.

## Conflicts and Counterevidence

- The assignment permits exactly one handoff at `/tmp/copilot/development-orchestration-dryrun-20261118/research.md`, while the Research Agent instructions and repository findings format require one dated report under `docs/research/`. These destinations conflict. This report follows the Research Agent's required location; no second temporary handoff was created.
- The selected Markdown category supports a narrow, isolated sample, but is counterevidence to treating the sample as an application change or visual-design task. It does not counter the plan's broader P4 coverage requirements.

## Constraints and Dependencies

- The plan places P4 after P1-P3 and sample selection. This assignment is at Research, so the dry-run itself was not performed.
- The shared contract sets a hard maximum of eight active agent instances. The 5/8 figure is assignment-provided and unverified; no delegation or new agent assignment occurred.
- The task excludes application/interpreter source, Logo-inspector work, builds, tests, staging, commits, pushes, and policy-enforcement claims.
- No QA verdict, stage approval, model-selection enforcement, or tool-enforcement result is claimed.

## Unknowns and Unverified Items

- The sample's exact text, target policy behavior, and expected decision are not approved.
- It is unknown whether the Markdown example is intended as one narrow vignette or as the sole record for all P4 scenarios.
- The reported active-instance count and prior retirements were not independently verified.
- Actual host enforcement of model, effort, tools, or stage gates was not observed.

## Search Coverage and Limitations

- Read the task assignment and the named plan and shared contract; searched only those workflow documents for the P4, stage-gate, visual-gate, and agent-limit passages. No source code, tests, other plans, or branch state were inspected. No public web search was needed for this local workflow question.
- A verbose read-only search result was automatically saved by VS Code under its session chat resources; that tool-managed output is not a task deliverable.

## Planning Handoff

Plan's minimal unresolved decisions are: (1) the specific policy behavior and authorized sample text; (2) whether the sample is a single vignette or is meant to represent P4's broader scenario set; and (3) what evidence is only a tabletop/procedural result versus evidence of actual host enforcement. The visual classification is expected N/A under the stated scope.

**Smallest discriminating check:** A tabletop hard-cap boundary using the assignment-reported 5/8 only as a stated premise: add three hypothetical instances to reach 8/8, then record the expected policy decision for a hypothetical ninth assignment as blocked. Do not launch agents; label this as a procedural simulation, not tool enforcement. This tests the ceiling rule only and does not establish full P4 coverage.

## Sources

- [Development orchestration plan](../plans/development-orchestration-workflow.md), especially P4 and “Plan Stage Deliverable”; dated 2026-11-17.
- [Development orchestration contract](../../.github/workflows/development-orchestration.md), especially “Stage Gates,” “Visual Design Gates,” and “Direct Assignment Contract”; date not stated.
- Task assignment DRYRUN-20261118-R1, user-provided, 2026-11-18.
- [Research Agent instructions](../../.github/agents/research.agent.md) and [research findings format](README.md), consulted for role and output requirements.

<!-- Co-authored by GitHub Copilot. Scope: orchestration policy dry-run research. Model/reasoning-effort: not independently observable. Measured wall-clock interval through this checkpoint: 4m59s (2026-11-18 14:28:11-14:33:10 UTC); final validation followed. Energy (kWh) and CO2: unavailable; no measured telemetry or defensible estimation inputs. -->
