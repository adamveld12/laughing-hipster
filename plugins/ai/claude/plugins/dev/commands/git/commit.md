---
description: 🚧 Creates a new commit using conventional commit guidelines. - Credits to Adam 🫡
argument-hint: <optional instructions>
allowed-tools: Bash(git:*), bash(pnpm turbo:*), Bash(gh:*)
model: haiku
---

## Objective

Use the @agent-git-god to review the git changes in the working directory and commit them with a conventional commits style commit message.

If you are on a branch that has an open PR, go ahead and push it and update the PR description to include the changes.

Below are additional instructions. Follow them carefully, but **always** use the conventional commit format.

If you were instructed to create a PR, respect the template here: @.github/pull_request_template.md. ALWAYS use the template. If possible from the branch name, begin the title with the ticket number.

<user_instructions>
"${ARGUMENTS}"
<user_instructions>
