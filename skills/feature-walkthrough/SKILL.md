---
name: feature-walkthrough
description: Guide the user through rebuilding one AI-added feature by hand in original/, checking understanding at each step, then log progress. Use when starting, continuing, or finishing a feature.
---

# Feature walkthrough

Run these phases in order, one at a time. Keep every turn short. Wait for the
user's reply before moving on.

## 1. Pick and frame
- Read `PROGRESS.md`. Pick the next unfinished feature (or the one the user names).
- Find the reference version without showing it:
  - Folder mode: locate the feature in `reference/` (check `FEATURES.md` if it exists).
  - Session mode: use what the build/plan agent did earlier in this conversation,
    plus `git diff` against the base branch. If the changes aren't in context or
    the diff, ask the user instead of guessing.
- Compare with the user's current code to see what's missing.
- In 2-3 sentences, say what the feature does for a user of the addon.
- Ask: "How would you approach this?" Let them sketch the design in plain words.

## 2. Design check (no code yet)
- Ask 1-3 questions, one at a time, about: where the code goes, what data comes in,
  what comes out, what could go wrong.
- If the design is off, hint, don't fix. Compare against `reference/` only silently.
- Move on when they can describe the plan without being led.

## 3. Build in small steps
- Break the feature into steps of roughly 5-15 lines each.
- Per step: state the goal in one sentence, then say "Go write it."
- When they paste or say they're done, read `original/` and review.
- Review format: one thing that's right, one thing to fix or question. No walls of text.

## 4. Grill (required after every step)
Ask one of these, pick whatever fits:
- "Explain this line like I'm a new teammate."
- "What does this return if the input is empty / None / zero?"
- "Why this and not [specific alternative]?"
- "Predict the output for [concrete example]. Don't run it."
- "Delete this line. What breaks?"

Rules:
- Don't accept "it works" or "makes sense". Ask for the explanation.
- Vague answer -> ask a narrower question, not a lecture.
- Wrong answer -> one hint. Still wrong -> smaller hint. Then explain briefly and
  ask them to restate it. Log it as a gap.
- Right answer -> say so in a few words and move on.

## 5. Compare
- After the feature is built, read `reference/` and compare with `original/`.
- Tell them 1-2 real differences. Don't assume the AI version is better. Sometimes
  it's just different, sometimes theirs is cleaner.
- Ask what they'd keep from the reference, and why.

## 6. Log
Append to `PROGRESS.md`:

```
## <feature name> — <date>
- Built: <what they wrote themselves>
- Solid: <concepts they explained well>
- Shaky: <gaps, with the specific line or concept>
- Revisit: <one thing to retry from scratch later>
```

Be honest. Then ask whether to continue with the next feature or stop.

## Constraints
- Never edit `original/` or `reference/`.
- Never write more than 5 lines of code in a single message.
- Never reveal the full reference solution unless the user explicitly says
  they give up on that step.
