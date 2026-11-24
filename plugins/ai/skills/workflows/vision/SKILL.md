---
name: workflow-vision
description: |
    Interview the user, then draft a vision document for a project proposal. Explains why we are building it, what the finished system looks like, who benefits, and shows the end result. Use when asked for a vision doc, project proposal, or alignment doc.
---

# Workflow: Vision

Produce a short document that makes a reader want the project and understand the end state. It covers the *why* and the *what*, not the migration or implementation plan (link to that separately).

## 1. Interview first

Do not draft until you have answers. Use the Question tool, a few questions at a time, and skip anything the repo, linked docs, or ticket already answers. Cover:

- **Audience:** who reads this, and what should they decide or feel afterward?
- **Today:** what is painful, and by how much? Get real numbers (time, cost, incidents, steps).
- **Target:** what does the finished system look like, and what are the measurable goals?
- **Mechanism:** the 2 to 5 changes that produce the improvement.
- **Proof:** what demonstrates the end result (diagram, screenshot, demo, before/after table)?
- **Out of scope:** what this doc deliberately does not cover, and where the plan lives.

Ask follow-ups on vague answers ("faster" means from what to what?).

## 2. Draft

Use this structure. Cut sections that do not apply.

1. **Hook:** one or two sentences stating the outcome with the headline number ("from hours to ~20 minutes"). No preamble.
2. **Why this doc:** what this covers, what it does not, a link to the companion plan, and the key before/after figures.
3. **The target:** the end state as a diagram (mermaid) and a short numbered walkthrough of the steps.
4. **Today vs. tomorrow:** a table comparing stages, marking what is unchanged, shrunk, or eliminated, with a total row.
5. **Why it is better:** the causes of today's pain paired with what the new system does about each. Cover reliability and simplicity, not only speed.
6. **The end result, shown:** screenshots, a UI tour, a demo, or a sample output so the reader can picture it.

## 3. Style

- Narrative first: problem, then effect, then mechanism. Each section answers "so what?".
- Concrete over abstract: real numbers, real names, bold the key figures.
- Short sentences, plain words, bullets over paragraphs. Stay brief.
- Mark unknowns and assumptions as such. Never invent numbers; ask or flag them.

## 4. Deliver

Write it where the user asks (Notion page, markdown file). If they didn't say, ask. Then offer one round of revisions.
