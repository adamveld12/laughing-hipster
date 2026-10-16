---
name: pr-review-chat
description: "Reviews a PR on Git"
---

 Review this PR: ${ARGUMENTS}

 The User will do the review himself and wants your findings only as input.

  Hard rules:
  - Do NOT comment on, reply to, approve, request changes on, or otherwise write to this PR or any other GitHub object. Read-only gh commands only (gh pr view, gh pr diff, gh api GET).
  - Do NOT edit or commit files, and do not check out the branch in ~/code/web (it has uncommitted changes). Read the diff with gh pr diff, and read repo files on main for context.

  What to do:
  1. Read the PR description and the full diff (`gh pr view <number> -R org/repo; gh pr diff <number> -R org/repo`).

  2. This is an automated "knowledge auto-update" PR, so first work out what generates it (look in ~/code/web for the workflow or script, e.g. grep for "knowledge: auto-update" in .github/ and bin/) and what a correct run should change. Then check the diff against that:
     - Are the changed files and content what the generator should produce?
     - Anything stale, wrong or contradictory with the code on main (paths, commands, names, claims that no longer hold)?
     - Anything that looks sensitive: secrets, credentials, internal URLs, customer data or PII?
     - Anything that looks unintended: unrelated files, large deletions, formatting churn, truncated or malformed content?
  3. Report your findings in this window, ranked by severity: Critical, High, Medium, Low, Nit. For each: file:line, what is wrong, why it matters, and a suggested fix. State plainly if there are no findings at a given level. Add a one-line overall verdict (safe to merge as is, or merge after fixes).
     Keep it concise.
