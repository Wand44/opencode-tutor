---
description: Test the feature we just built in a scratch session
agent: tutor
---

We just finished a feature. Test it.

1. Ask me to predict what should happen, in one sentence. Wait for my answer.
2. Then, using the external tool (I'll approve each call):
   - create a NEW scratch scene and run everything there,
   - never clear, edit or delete anything in my open scene,
   - make sure the addon being tested is the one in `original/`
     (check the loaded module path first and tell me if it's something else),
   - include at least one edge case (empty, name collision, undo),
   - delete the scratch scene when done.
3. Report in a short table: check, expected, actual.
4. If something fails, don't fix it. Ask me what I think the cause is.
