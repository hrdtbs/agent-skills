---
name: comprehensive-nextjs-expert
description: A comprehensive master skill for modern Next.js development using the App Router, React, TypeScript, and Tailwind CSS. Make sure to use this skill whenever the user asks to build, refactor, or debug Next.js applications, server components, or mentions React, RSC, SSR, SSG, or Tailwind CSS within a Next.js context.
---

# Comprehensive Next.js Expert

This skill provides comprehensive guidelines and best practices for developing high-quality, modern applications using Next.js (App Router), React, TypeScript, and Tailwind CSS. It is designed to enforce consistency, performance, and maintainability across all Next.js projects.

## Core Principles
1. **Server Components by Default:** Rely on React Server Components (RSC) to reduce client-side JavaScript and improve performance. Use client components (`"use client"`) only when interactivity or browser APIs are strictly required.
2. **TypeScript for Everything:** Use TypeScript for all files to ensure type safety. Prefer interfaces over types for object shapes and avoid enums (use object maps or union types instead).
3. **App Router Structure:** Strictly follow the Next.js App Router conventions. Utilize `layout.tsx`, `page.tsx`, `loading.tsx`, `error.tsx`, and `route.ts` appropriately.
4. **Functional Programming:** Use functional components and declarative patterns. Avoid class components entirely.

## Project Structure & Naming
- Use lowercase with dashes for directories and file names (e.g., `components/auth-wizard`, `app/dashboard`).
- Group files by feature where applicable.
- Export components using named exports rather than default exports (except for App Router special files like `page.tsx` and `layout.tsx` which require default exports).
- Define types and interfaces alongside the components that use them, or in a dedicated `types` directory for shared types.

## Data Fetching & State
- Fetch data on the server within Server Components using `fetch` or direct database calls (e.g., via Drizzle or Prisma).
- Do not use `useEffect` or `useState` for data fetching.
- Use Server Actions for data mutations and form submissions.
- Model expected errors as return values from Server Actions. Avoid relying on `try/catch` block for expected control flow.
- Use tools like `nuqs` for URL search parameter state management rather than complex React state for URL-driven state.

## Styling & UI
- Use Tailwind CSS for all styling. Employ a mobile-first approach.
- For UI components, prefer robust accessible libraries like Shadcn UI or Radix UI.
- Use utility libraries like `clsx` and `tailwind-merge` for dynamic class construction.
- Optimize assets: Utilize the `next/image` component for all images to ensure WebP formatting, lazy loading, and correct sizing.

## Error Handling
- Validate all incoming data, especially from Server Actions, using validation libraries like Zod.
- Use `error.tsx` and `global-error.tsx` to catch unexpected errors gracefully and provide a fallback UI.
- Handle edge cases at the top of your functions (early returns) to avoid deeply nested conditional logic.

## Anti-Patterns (NEVER Do These)
- **NEVER use `"use client"` globally or at the top level without a specific reason.**
  *Why:* It defeats the purpose of React Server Components, unnecessarily increasing the JavaScript bundle size shipped to the client and degrading performance.
- **NEVER fetch data using `useEffect` on the client if it can be fetched on the server.**
  *Why:* Client-side fetching introduces waterfalls and worsens the First Contentful Paint (FCP) and overall user experience.
- **NEVER use complex inline conditional logic with curly braces when unnecessary.**
  *Why:* It reduces readability. Prefer early returns or simple one-line syntax (e.g., `if (condition) return;`).
- **NEVER use classes for React components.**
  *Why:* The React ecosystem has fully transitioned to functional components with Hooks. Classes are legacy and add unnecessary verbosity.
- **NEVER ignore the Next.js routing conventions (e.g., naming a route file `index.tsx` inside the `app` directory).**
  *Why:* The App Router relies strictly on file names like `page.tsx` or `layout.tsx` to function. Deviating from this breaks routing.
