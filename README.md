# tutor

Config repo for the coding-tutor setup. Tracks only the tutor files.

| File | What it is |
| --- | --- |
| `agents/tutor.md` | The tutor agent (primary, edit-locked to `PROGRESS.md` / `FEATURES.md` / `reports/`) |
| `commands/start.md` | `/start [base-ref]` — sets up a session and writes `FEATURES.md` + `PROGRESS.md` |
| `commands/recall.md` | `/recall` — cold-recall check on earlier Shaky/Unverified gaps |
| `commands/test.md` | `/test` — checks the feature in a scratch Blender scene, each call approved |
| `skills/feature-walkthrough/SKILL.md` | Skill the tutor runs per feature |
| `start-session.sh` | Creates `original/` (base commit) and `reference/` (working tree) in a target repo, drops duplicated root files |

## Use

```sh
cd ~/path/to/your/project     # must be a git repo with at least one commit
bash ~/.config/opencode/start-session.sh [base-ref]   # default base: HEAD
```

Then in opencode: Tab to the **tutor** agent, run `/start`.

You rebuild features by hand in `original/`. `reference/` is the AI-built version —
read it, never paste from it. Progress lands in `PROGRESS.md`.

`original/`, `reference/`, `PROGRESS.md`, `FEATURES.md` and `reports/` are gitignored.