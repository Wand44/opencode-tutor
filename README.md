# tutor

An AI-built version of your code sits in `reference/`. `original/` is your copy at
your last git commit — you rebuild it by hand, feature by feature, and the tutor
grills you on each step before moving on.

The tutor never writes your code. It asks until you can explain it back.

## Usage

In opencode, inside a git repo with at least one commit:

1. Tab to the **tutor** agent.
2. Run `/start` — optionally `/start <base-ref>` to rebuild from an older commit.

That's it. `/start` runs `start-session.sh` for you (creates `original/` and
`reference/`, then writes `FEATURES.md` and `PROGRESS.md`). Don't run the script
by hand.

Then just keep talking. The tutor reads `PROGRESS.md`, picks the next feature, and
walks you through it.

| Command | What it does |
| --- | --- |
| `/start [base-ref]` | Sets up the session and lists the features to rebuild |
| `/recall` | Re-tests earlier gaps you never explained |
| `/test` | Checks the feature in a scratch Blender scene, each call approved for you |

## Files

| File | What it is |
| --- | --- |
| `agents/tutor.md` | The tutor agent (primary, edit-locked to `PROGRESS.md` / `FEATURES.md` / `reports/`) |
| `commands/start.md` | `/start` |
| `commands/recall.md` | `/recall` |
| `commands/test.md` | `/test` |
| `skills/feature-walkthrough/SKILL.md` | Skill the tutor runs per feature |
| `start-session.sh` | Creates `original/` (base commit) and `reference/` (working tree) in a target repo, drops duplicated root files |

## Folders in the project you learn in

| Folder | What it is |
| --- | --- |
| `original/` | Your working copy. You write all code here. |
| `reference/` | The AI-built version. Read it, never paste from it. |
| `PROGRESS.md` | What's built, what's solid, what's shaky. |
| `FEATURES.md` | One line per AI-added feature. |

All of those are gitignored.