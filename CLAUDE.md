# Long-running work

- Never park a session waiting on an event that is more than about an hour
  away (an A/B, a data-gen run, CI that queues). No `Monitor`, no tracked
  background job, no wakeup chain. It outlives the prompt cache (1 h today,
  5 min under overage) and the session itself is fragile over hours.
- Instead: launch the job detached, write the in-flight state to memory
  (what is running, where its output lands, what verdict is owed, the seed),
  and end the turn. The next session picks it up from the memory index.

# Turned-off skills

`skillOverrides` in ~/.claude/settings.json turns these skills off (set 2026-10-29,
because they went unused for a month). If I ask for something in one of these
areas, say which skill is off before doing the work without it.

- Over-engineering reviews/audits, ponytail debt or help: ponytail:ponytail-{audit,debt,help,review}
- Watching videos: watch:watch
- Debugging, TDD, prototypes, domain/ADR modeling, module design: mattpocock-skills:{diagnosing-bugs,tdd,prototype,domain-modeling,codebase-design}
- Code review, PR bodies, setup wizards, writing skills/CLAUDE.md: mattpocock-skills:{code-review,pr,wizard,writing-for-agents}, code-review, simplify, security-review, anthropic-skills:skill-creator
- Claude Code config: keybindings-help, fewer-permission-prompts, plugin-authoring, init
- Recurring or scheduled runs, launching the app: loop, schedule, run
- Claude API / Anthropic SDK: claude-api
- Browsers, desktop control, artifact screenshots: anthropic-skills:{built-in-browser,chrome-browser,computer-use,artifact-emulator}
- Research reports, morning brief, memory import: anthropic-skills:{deep-research,morning,import-memory}
- Office/PDF/Google files: anthropic-skills:{docx,pptx,xlsx,pdf,google-workspace}
