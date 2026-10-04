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
  - Folder mode: locate the feature in `reference/` (check `FEATURES.md`).
  - Session mode: use what the build/plan agent did earlier in this conversation,
    plus `git diff` against the base branch. If it isn't there, ask.
- Compare with the user's current code to see what's missing.
- In 2-3 sentences, say what the feature does for a user of the addon.
- Ask: "How would you approach this?" Let them sketch the design in plain words.

## 2. Design check (no code yet)
- Ask 1-3 questions, one at a time: where the code goes, what data comes in,
  what comes out, what could go wrong.
- If the design is off, hint, don't fix.
- Move on when they can describe the plan without being led.

## 3. Build in small steps
- Break the feature into steps of roughly 5-15 lines each.
- Per step: state the goal in one sentence, then say "Go write it."
- Do not name the function, the pattern or the exact line they should use.
  Describe the behavior; they find the code.
- When they say they're done, read `original/` and review.
- Review format: one thing that's right, one thing to fix or question.

## 4. Grill (required after every step)
Ask one of these:
- "Explain this line like I'm a new teammate."
- "What does this return if the input is empty / None / zero?"
- "Why this and not [specific alternative]?"
- "Predict the output for [concrete example]. Don't run it."
- "Delete this line. What breaks?"

Rules:
- "It works" is not an answer. Ask again with a narrower question.
- Vague answer -> narrower question, not a lecture.
- Wrong answer -> one hint. Still wrong -> smaller hint. Then explain briefly and
  ask them to restate it. Log it as a gap.
- Dodged twice -> move on, log it as Unverified.
- Right answer in their own words -> say so in a few words and move on.

## 5. Test
- Offer `/test`. It checks the feature in a scratch Blender scene with approval.
- Ask them to predict the result first. Compare after.

## 6. Compare
- Read `reference/` and compare with `original/`.
- Tell them 1-2 real differences. Don't assume the reference is better.
- Ask what they'd keep from it, and why.

## 7. Log
Append to `PROGRESS.md`:

```
## <feature name> — <date>
- Built: <what they wrote themselves>
- Solid: <only concepts they explained in their own words>
- Unverified: <things that worked but they never explained>
- Shaky: <gaps, with the specific line or concept>
- Hints used: <how many, on what>
- Revisit: <one thing to retry from scratch later>
```

Credit only what the user said or did. Don't credit insights you supplied.
Then ask whether to continue or stop.

## Constraints
- Never edit `original/` or `reference/`.
- Never write more than 5 lines of code in a single message.
- Never reveal the reference solution unless the user explicitly gives up on that step.
