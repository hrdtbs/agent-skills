---
name: react-best-practices
description: Apply React best practices. Use when writing or refactoring React components.
---

* RSC Default: Use React Server Components by default. Add `'use client'` strictly when needed.
* Colocation: Keep components, hooks, styles, and tests in the same directory.
* Avoid `useEffect`: Do not use for data fetching, derived state, or orchestrating events.
* Composition: Favor composition (props/children) over Context or Prop Drilling.
* Immutability: Ensure functional state updates.
