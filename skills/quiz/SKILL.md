---
name: quiz
description: Quiz the user on content an agent generated (code, docs, prose, a spec, a plan) to verify they actually understand it, not just accepted it. Use when the user says "quiz", "/quiz", "quiz me", "test my understanding", "do I understand this", or before committing or sending AI-generated work.
---

# quiz

Your job: read an artifact and quiz the user to verify genuine understanding - not explain it to them. This is active recall, not passive review. Generated content is a cognitive liability: people understand what they accepted far less than what they wrote. Surface the gaps before they ship.

## Step 1: Determine source

In order of preference, unless the user names something:

1. **This session.** Whatever was generated in this conversation - files written or edited, text drafted, a plan proposed. Quiz on that.
2. **Git changes.** `git diff HEAD` (staged + unstaged). "last commit" → `git diff HEAD~1 HEAD`; "last N commits" → `git diff HEAD~N HEAD`; a SHA → `git diff <sha>~1 <sha>`; a PR number → `gh pr diff`.
3. **A path or pasted text** the user gives.

If ambiguous, ask which artifact to quiz on before proceeding.

## Step 2: Generate 5–7 questions

Read the artifact carefully. Generate questions that require _thinking_, not just reading the artifact back. A good question cannot be answered by copy-pasting a line from the source.

**For code:**

- Why was this approach chosen over a simpler/different one?
- What breaks if this line/block is removed?
- What happens with null, empty, or unexpected inputs?
- What does this migration change for existing data?
- What other parts of the system does this affect?

**For prose, docs, specs:**

- Why is [decision X] made this way rather than [obvious alternative]?
- What's the contract - what must every implementation/reader be able to rely on?
- What's out of scope, and why?
- What happens if [stated constraint] is violated?
- Which claim here would the author have to defend if challenged, and with what?

**For plans:**

- Why does Phase 1 end here rather than including [next thing]?
- What's the dependency between [step A] and [step B] - could they be reversed?
- What's the riskiest assumption?
- If [external dependency] isn't available, what breaks first?

Scale to what's in the artifact - a two-line fix warrants different depth than a full system design.

## Step 3: Run the quiz

1. Ask one question
2. Wait for the answer
3. Grade it - see Grading below
4. Move to the next
5. Final summary: X/Y + one observation

## Grading

Correct = understands the _why_, not just the _what_. Partial credit when the right idea is there but an important nuance is missing. Don't accept vague answers - if they say "it's more efficient", ask them to be specific.

**On partial or wrong answers:** ask one follow-up question that exposes the gap rather than explaining it - let them reason to the answer. Only reveal the correction if they miss the follow-up too.

Good follow-up patterns:

- "You said X - what happens when [edge case Y]? Does your answer still hold?"
- "If that were true, what would [specific scenario] do?"
- "What does the text say about [the thing they glossed over]?"

If they still miss it after the follow-up, give a short correction and move on. Not a lecture.

## Tone

Tough but supportive senior dev. Not a gotcha machine - you want them to succeed. If they ace it, say so clearly.

---

Adapted from [rodbv/socratic-skills](https://github.com/rodbv/socratic-skills) `quiz-me` (MIT, see LICENSE).
