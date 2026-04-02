# Routing, Layouts, and Patterns in Next.js

The App Router provides powerful mechanisms for structuring your application UI, handling state, and managing edge cases.

## Core Routing Concepts

### 1. Layouts vs Templates

- **`layout.tsx`:** Defines UI shared across multiple routes. A layout's state is preserved across navigations, meaning components do not remount when navigating between child routes.
- **`template.tsx`:** Similar to a layout but creates a new instance for each child on navigation, meaning state is not preserved and effects re-run. Use only when you specifically need this behavior (e.g., triggering animations on enter, resetting form state).

### 2. Loading and Error Boundaries

The App Router uses React Suspense and Error Boundaries to handle async boundaries gracefully.

- **`loading.tsx`:** An automatic Suspense boundary. It is shown immediately while the child components are loading. Useful for whole-page or significant section loading states.
- **`error.tsx`:** An automatic Error Boundary. Must be a Client Component (`"use client"`). Catches errors during rendering, data fetching, and mutations within its subtree, allowing recovery without crashing the entire app.

### 3. Nested Routing Structure

The App Router structures URLs based on the folder hierarchy.

- `/app/dashboard/settings/page.tsx` maps to the `/dashboard/settings` URL.
- To share UI (like a sidebar) across `/dashboard/*`, use `/app/dashboard/layout.tsx`.

## Advanced Routing Patterns

### Intercepting Routes (`(..)`)

Intercepting routes allow you to load a route from another part of your application within the current layout, without losing context. This is most commonly used for modals.

- `(...)` to intercept the root `app` directory.
- `(..)` to intercept one level above.
- `(.)` to intercept the same level.

When navigating directly to the URL (e.g., refresh or shared link), the full page renders. When navigating from within the app, the intercepted version (e.g., a modal) renders over the existing UI.

```text
app/
├── feed/
│   ├── page.tsx
│   └── (..)photo/[id]/page.tsx // Intercepts the photo route when navigated from feed
├── photo/
│   └── [id]/page.tsx           // The full page version
```

### Parallel Routes (`@folder`)

Parallel routing allows you to simultaneously render multiple pages within the same layout. This is excellent for complex dashboards where independent sections need their own loading and error states.

- Parallel routes are defined using named slots (e.g., `@analytics`).
- They do not affect the URL structure.

```text
app/dashboard/
├── layout.tsx
├── @analytics/page.tsx
└── @team/page.tsx
```

```tsx
// app/dashboard/layout.tsx
export default function Layout({
  children,
  analytics,
  team,
}: {
  children: React.ReactNode
  analytics: React.ReactNode
  team: React.ReactNode
}) {
  return (
    <div>
      {children}
      {analytics}
      {team}
    </div>
  )
}
```

### Route Groups (`(folder)`)

Route groups allow you to logically organize routes without affecting the URL path. This is useful for grouping routes that share a layout or separating different sections of an application (e.g., `(marketing)` vs `(app)`).

```text
app/
├── (marketing)/
│   ├── layout.tsx     // Only applies to marketing routes
│   ├── about/page.tsx // /about
│   └── blog/page.tsx  // /blog
├── (app)/
│   ├── layout.tsx     // Only applies to app routes
│   └── dashboard/page.tsx // /dashboard
```
