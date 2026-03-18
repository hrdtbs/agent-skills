---
name: react-best-practices
description: "Expert guidance for writing modern, maintainable, and performant React code. Make sure to use this skill whenever the user asks to write, refactor, review, or debug React code, hooks, components, or discusses state management, effects, or React performance optimization."
---

# React Best Practices

This skill provides expert guidance for writing modern, scalable, and maintainable React code. Adhere strictly to these rules whenever you write, refactor, or review React code.

## Flow Control

When applying React best practices, you MUST follow this sequence:

1. **Read Domain Guidelines**: Before modifying or creating any React code, read `references/react-guidelines.md` for specific rules on components, hooks, state management, effects, and performance optimization.
   - Use the `read_file` tool to load `skills/react-best-practices/references/react-guidelines.md`.

2. **Diagnose and Plan**:
   - Analyze the current code or request against the guidelines.
   - Plan your changes (e.g., removing unnecessary `useEffect`s, extracting custom hooks, optimizing re-renders with `useMemo`/`useCallback`, implementing proper state colocation).

3. **Apply Guidelines**:
   - Write or refactor code strictly according to the guidelines.
   - Ensure components are pure, side-effects are properly managed, and the code follows modern React patterns.

4. **Verify**:
   - Verify that your hooks have correct dependency arrays.
   - Ensure there are no state mutations and performance is not unnecessarily degraded by excessive re-renders.

## Core Directives

- **Components Must Be Pure**: Given the same inputs (props, state, context), a component must always return the same JSX. Never mutate external variables or objects during render.
- **You Might Not Need an Effect**: Avoid `useEffect` for data transformation or state synchronization that can be calculated during render. Only use effects for synchronizing with external systems (network, DOM, third-party libraries).
- **Colocate State**: Keep state as close as possible to where it's used. Avoid lifting state up higher than necessary to prevent unnecessary re-renders of unrelated components.
- **Strategic Memoization**: Do not blindly wrap everything in `useMemo` or `useCallback`. Only use them to memoize expensive calculations or to preserve referential equality when passing props to optimized child components (like those wrapped in `React.memo`).
- **Composition over Inheritance**: Use children props and render props to create flexible, reusable components rather than building complex components with dozens of configuration props.

Always start by reading the guidelines in `references/react-guidelines.md`!
