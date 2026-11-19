# Review Documents: Instructions for AI Agents

A review document is the permanent record of a stretch of work: what was done, why, what went wrong,
how it was fixed, and what was decided. Its reader is someone who arrives later (the user, a future
session, another model) because something broke or something needs understanding. They must find
the answer in the review, without reading chat histories, error logs, or diffs.

Write one at the end of every stretch of work. Keep notes while working so that writing it is
assembly, not archaeology.

---

## 1. When to write one

- **Always** at the end of any stretch of work the user asked for: a release, a feature, a bug hunt,
  an incident, a refactor, a setup or configuration task, a data or model run.
- **Without being asked.** The last step of the work is the review. Mention it in the final reply,
  with its path.
- **Scale it to the work.** A one-hour fix gets a short review (summary, what happened, problems,
  decisions, state). A multi-hour release gets the full structure in section 5. Never skip one
  because the work was small; small work is where reasons get lost.
- **Not for** pure questions, explanations, or read-only investigation, unless the investigation
  found something the project must remember (a root cause, a constraint, a gotcha). Then write it.
- If a session ends before the work does (context limit, crash, user stops), write a partial review
  of what exists and say it is partial.

## 2. Where it goes and what it is called

- **Always in a hidden `.review-logs/` directory (leading period) at the project root** (the
  directory that holds the git repository), in every project. Create it if it does not exist. The
  folder holds reviews, running notes, and the log files they cite. Where the git repository is a
  subdirectory of the workspace, put `.review-logs/` at the workspace root, outside the repository.
- **Always untracked in git.** Before writing the first file, make sure `.review-logs/` is listed in the
  project's `.gitignore`; add it if not. Never stage or commit anything under `.review-logs/`. If
  `git status` shows files under `.review-logs/`, fix the ignore rule before doing anything else.
- Name files `<YYYY-MM-DD>_<short-topic>.md`. For a release, use `<YYYY-MM-DD>_release-<version>.md`.
- **One file per release or per stretch of work.** Never combine two releases in one file.
- Link related reviews to each other by file name and section number.

## 3. Document as you go (the habit)

From the first action of any stretch of work longer than a few steps:

1. **Open a running notes file** at `.review-logs/<YYYY-MM-DD>_<topic>-notes.md`. Write to it at each
   milestone, not at the end.
2. Record in it, with the local time:
   - each decision and the options rejected, with the reason;
   - each error: the exact message, the command that produced it, the root cause once found, the fix;
   - each measured number that matters, with its source file and the size it was measured on;
   - anything chosen where the spec or the user was silent;
   - user instructions that change how the work is done.
3. **Send long outputs to log files** with predictable names (`.review-logs/logs/<item>-<step>.log`) and
   note the path, so the review can cite them.
4. Notes survive crashes and context loss; after a crash or freeze they may be the only record of
   the work. Treat the notes file as part of the work.

## 4. Gathering sources before writing

Use, in this order of trust:

1. **First-hand observation** in the current session (commands run, outputs seen).
2. **Committed artifacts:** `git log`, `git show --stat`, reports, metrics files, the code itself.
3. **Running notes, handoffs, and log files** written during the work.
4. **Session transcripts** in `~/.claude/projects/<project>/<session>.jsonl`, for work done in an
   earlier or crashed session. Condense one to a timeline first (timestamps, user messages,
   commands, result heads, errors) with a short script; never read the raw file into context.
   Transcript timestamps are UTC.
5. **System records** when relevant: `journalctl`, file modification times.

Never invent detail a source does not hold. When something is unknown, write that it is unknown.

## 5. Structure

Use these sections in this order. Omit a section only when it would be empty, and say so in one
line rather than leaving a reader to wonder.

1. **Title and purpose paragraph.** What stretch of work, from which state to which state (tags,
   commits, dates). Where the file lives, when it was written, and the time zone used.
2. **At a glance.** A table a reader can absorb in one minute: what changed, the result, headline
   numbers, the biggest incident, user decisions, time taken, commits.
3. **Contents** with working anchor links.
4. **Sources and how much to trust each part.** Which parts are first-hand, which came from a
   transcript, which were reconstructed from files.
5. **Starting state.** What was true before the work, and the checks that confirmed it.
6. **Goal.** What the work set out to do (the spec, the user's request), with the plan as a table.
7. **How the work was organised.** Roles, agents, worktrees, approvals, and any process instruction
   or correction from the user, quoted.
8. **Timeline and time spent.** A commit timeline (time, SHA, message) and a phase table (from, to,
   wall time, what took the time). Compare any estimate given during the work with the outcome.
9. **The work, item by item.** For each item: the spec in brief; the context given to any agent;
   what was delivered (files, functions, interfaces); what review found; problems and their fixes;
   tests and the verify result; the commit. Quote the exact commands and error messages that
   mattered, in code blocks.
10. **Incidents**, each in full: what was observed; the evidence and the commands that produced it;
    the root cause as a chain of causes; what was and was not lost; each fix and how it was proven;
    what changed in process so it cannot recur.
11. **Every problem and its resolution.** A numbered table in the order problems happened: item,
    problem (exact symptom), root cause, resolution. Include process slips and harness issues. Mark
    any problem that repeats an earlier one, with a reference to where it first appeared.
12. **Decision log.** A table: decision, alternatives considered, why. Include defaults taken where
    the spec was silent and choices made on the user's behalf.
13. **Insights.** Short, general lessons a future reader can apply, each tied to the event that
    taught it.
14. **File inventory.** Files created and changed (tracked), and everything outside the repository
    (data, configs, memory, machine changes).
15. **Test inventory.** Test count over time, how testing was done, mutation or coverage results.
16. **Command reference.** The commands needed to reproduce, verify, or debug the work, grouped and
    commented.
17. **Numbers, before and after.** Tables with the size, seed, and source of every number.
18. **State at the end, and what is still open.** Branch, commits, tags, pushed or not, tests and
    gates, and every open item with enough detail to act on it.

For a short review, keep sections 1, 2, 5, 9 (or a single "What happened"), 11, 12, and 18.

## 6. Writing rules

- **Plain, exact language.** Short sentences. Define a term on first use. No filler, no hype, no
  hedging that hides a fact.
- **No emojis.** No day or week labels in anything that reaches git.
- **Local time** (IST for this user), stated once at the top.
- **Name the size behind every number:** users, days, seeds, split, machine load. Two numbers from
  different sizes must never sit side by side without saying so.
- **Cite the source of every number** (report path and key, artifact, log file).
- **Quote, do not paraphrase,** error messages, user instructions, and key command output.
- **Say why for every decision,** including the alternatives rejected.
- **Say what is unknown or unverified** rather than smoothing it over.
- **Write for the reader who arrives cold.** Explain the project-specific terms the review depends
  on, or link to where they are explained (an earlier review's section).

## 7. Before calling a review finished

1. **Check every number** against its committed source. If another document disagrees, correct the
   other document too and record the correction.
2. **Check every claim about the past** against git, logs, or the transcript; remove anything you
   cannot support.
3. **Check links:** every contents anchor and every cross-reference resolves.
4. **Check the rules:** no emojis, no day labels, no secrets or credentials, no private personal
   details beyond what the project already records.
5. **Update the companions:** the project's execution log or changelog, the open-items list, the
   TODO list, and earlier reviews whose open items this work closed (with a dated addendum).
6. **Tell the user:** one paragraph on what the review covers, its path, and anything it found that
   needs their attention.

## 8. Changing earlier reviews

- **Do not rewrite history.** Later facts go in a dated `Addendum (YYYY-MM-DD)` section at the end of
  the earlier review: what changed, when, and where it is recorded.
- Fixing a file name, a broken link, or a cross-reference is maintenance, not rewriting; do it in place.
- When structure changes (a split, a rename), record it in the purpose paragraph of each affected
  file and update every inbound reference.
- When a later review finds an earlier one wrong on a fact, correct the fact in place, and add one
  line to the addendum saying what was corrected and why.

## 9. What a good review lets a reader do

Test every review against these questions. If any answer requires leaving the document, the review
is not finished.

- Why is this code, config, or number the way it is?
- What broke before, why, and how do I recognise the same failure?
- What was decided, and what was rejected?
- How do I reproduce the result or re-run the work?
- What is still open, and where would I start on it?
- How long did it take, and what took the time?
