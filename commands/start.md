---
description: Start a tutor session (original/ = base commit, reference/ = AI-built version)
agent: tutor
---

Setup output:

!`bash ~/.config/opencode/start-session.sh $ARGUMENTS`

If the setup failed, tell me what went wrong in one or two sentences and stop.

Otherwise:
1. Compare `original/` and `reference/` (use `diff -rq` and read the changed files).
2. Write `FEATURES.md`: one line per distinct feature the AI added, as
   `- <name>: <one-line description> (files: <paths in reference/>)`.
   Describe what each does for a user, not how it's built.
3. Create `PROGRESS.md` with a title and an empty list of features,
   all marked not started.
4. Tell me in 2-3 sentences how many features you found and which look
   easiest to start with. Ask which one I want to rebuild first.

Don't show any implementation from `reference/`.
