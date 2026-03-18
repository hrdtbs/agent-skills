# React Guidelines

This document provides detailed rules and patterns for writing modern, maintainable, and performant React applications. Follow these guidelines strictly.

## 1. Component Architecture & Patterns

### 1.1 Pure Components
- **Rule**: Components must be pure functions. Given the same inputs (props, state, context), they must return the same output (JSX).
- **Anti-pattern**: Mutating external variables, objects, or arrays during render.
- **Anti-pattern**: Calling `Math.random()`, `Date.now()`, or other impure functions during render without storing their output in state or a ref.

### 1.2 Composition over Configuration
- **Rule**: Prefer composition (using `children` or render props) over creating complex components with dozens of boolean configuration props.
- **Why**: It makes components more flexible, reusable, and easier to understand, reducing the "prop drilling" problem and "god components."

### 1.3 Keep Components Small and Focused
- **Rule**: Break down large components into smaller, more focused sub-components. A component should ideally do one thing well.
- **Signal**: If a component file exceeds 200-300 lines, or contains multiple `useEffect` hooks and complex state management, it's a strong candidate for refactoring.

## 2. Hooks & State Management

### 2.1 Colocate State
- **Rule**: Keep state as close to where it's used as possible.
- **Why**: Prevents unnecessary re-renders of parent components and keeps related logic together. Don't lift state up unless multiple separate components need to share it.

### 2.2 You Might Not Need an Effect
- **Rule**: Avoid using `useEffect` for data transformation or synchronizing state. If a value can be calculated from existing props or state during render, calculate it during render.
- **Anti-pattern**: Using `useEffect` to update state based on prop changes.
- **Solution**: Derive state directly during render. If it's expensive, use `useMemo`.

### 2.3 Correct Effect Dependencies
- **Rule**: Every value referenced inside a `useEffect` that is part of the component scope (props, state, functions) MUST be included in the dependency array.
- **Anti-pattern**: Lying to the linter by omitting dependencies or using `eslint-disable-next-line react-hooks/exhaustive-deps`.
- **Solution**: If a dependency causes too many re-renders, the effect is likely doing too much, or the dependency is an unstable object/function (fix with `useMemo`/`useCallback` or move it inside the effect).

### 2.4 Custom Hooks for Logic Reusability
- **Rule**: Extract complex component logic (especially involving multiple hooks like `useState` and `useEffect`) into custom hooks.
- **Why**: Separates UI from business logic, making both easier to test and reuse. Custom hooks should start with `use`.

## 3. Performance Optimization

### 3.1 Strategic Memoization
- **Rule**: Do NOT prematurely memoize everything. Only use `useMemo` and `useCallback` when necessary.
- **When to use**:
  - To memoize the result of an expensive calculation (e.g., sorting or filtering a large list).
  - To preserve referential equality of an object or function passed as a prop to a child component that is wrapped in `React.memo` or used in a child's `useEffect` dependency array.

### 3.2 Key Prop in Lists
- **Rule**: Always provide a unique and stable `key` prop when rendering lists of elements.
- **Anti-pattern**: Using the array index as the `key` (unless the list is static, never reordered, and items are never added or removed).
- **Why**: React uses keys to identify which items have changed, been added, or been removed, optimizing rendering performance and maintaining correct state.

## 4. Anti-Patterns to Avoid

- **Mutating State Directly**: Never mutate state objects or arrays directly (e.g., `state.push(item)`). Always return a new object/array (e.g., `setItems([...items, item])`).
- **Prop Drilling**: Passing props deeply through multiple levels of components that don't need them. Use Context API, state management libraries (Zustand, Redux), or Component Composition instead.
- **Direct DOM Manipulation**: Avoid using `document.getElementById` or `document.querySelector` inside React components. Use `useRef` to interact with DOM elements directly only when absolutely necessary (e.g., managing focus, interacting with third-party DOM libraries).

## 5. TypeScript with React

- **Rule**: Always type your component props using TypeScript `type` or `interface`.
- **Rule**: Avoid `React.FC` or `React.FunctionComponent`. Define components as normal functions and type their props directly (e.g., `function Button(props: ButtonProps) { ... }`).
- **Rule**: Type `children` explicitly using `React.ReactNode` if the component accepts children.
