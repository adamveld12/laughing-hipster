# Question bank

Angles to rotate through during questioning rounds. Adapt each one to the idea; never read them out verbatim.

## Problem (Socratic)

- Why is this a problem now? What changed?
- What evidence shows it is real? Can PostHog confirm it?
- Who does **not** have this problem, and why?
- If we solved it perfectly, what would the user do differently?
- Is this the problem itself, or a symptom of a deeper one?

## Scope splitting

- You mentioned X and Y. If you could only ship one, which one?
- Does Y still matter if X is solved?
- What is the smallest version that removes the pain?

## Feynman playback

- "So in plain terms: <restatement>. What did I get wrong?"
- Explain it to a storm chaser who has never used the site.

## Users & access

- Which access flag gates this: public, `stormLabAccess`, `meteorologistAccess`, `isAdmin`, or a new flag?
- What does someone without access see?
- Does it behave differently for signed-out users?

## Data & system

- Where does the data come from (a worker scrape, KV, a third party)? How fresh must it be?
- What happens when the source is down, slow, or wrong?
- Does this change what the worker scrapes or caches?

## Edge cases

- Empty state, first use, no data for the region or date.
- Offline, slow network, mobile.
- Very large volume (a huge storm day, many reports).
- Conflicting or stale data.

## Success & analytics

- What number moves if this works? What is it today?
- What PostHog events prove it is used?
- What result would make us roll it back?

## Rollout

- Behind a PostHog flag? Who gets it first?
- What gate must be passed to advance to the next stage?
- How do we turn it off, and what do users see then?

## Non-goals & alternatives

- What will people assume this does that it won't?
- What other approaches did you consider? Why not those?
- What is the cheapest alternative, including doing nothing?
