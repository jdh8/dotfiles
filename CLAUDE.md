# Long-running work

- Never park a session waiting on an event that is more than about an hour
  away (an A/B, a data-gen run, CI that queues). No `Monitor`, no tracked
  background job, no wakeup chain. It outlives the prompt cache (1 h today,
  5 min under overage) and the session itself is fragile over hours.
- Instead: launch the job detached, write the in-flight state to memory
  (what is running, where its output lands, what verdict is owed, the seed),
  and end the turn. The next session picks it up from the memory index.
