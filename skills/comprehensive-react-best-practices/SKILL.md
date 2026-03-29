---
name: comprehensive-react-best-practices
description: Comprehensive React and Next.js best practices and performance optimization guidelines. Use this skill WHENEVER you write, refactor, or review React components, Next.js pages, hooks, or state management code. Make sure to use this whenever the user asks for React help, mentions Next.js, or needs frontend UI development, even if they don't explicitly ask for "best practices".
---

# Comprehensive React & Next.js Best Practices

A skill to guide you in writing performant, clean, and modern React and Next.js applications.

Writing React code is easy, but writing *performant* and *scalable* React code requires a deeper understanding of how rendering, data fetching, and state management work under the hood. The goal of this skill is to help you build applications that avoid common anti-patterns like request waterfalls, excessive client-side rendering, and bloated JavaScript bundles.

## Guidelines

### 1. Eliminating Waterfalls (Data Fetching)
**The "Why":** Request waterfalls occur when a component waits for a parent component to finish fetching data before it can start its own fetch. This significantly delays the Time to First Byte (TTFB) and overall page load time. By fetching data in parallel, we allow the browser to do more work concurrently.

*   **Prefer parallel fetching:** When multiple independent pieces of data are needed, fetch them together using `Promise.all` rather than awaiting them sequentially.
*   **Hoist data fetching:** If a parent and child component both need data, try to fetch it at the highest common parent or fetch in parallel at the routing level.

### 2. Bundle Size Optimization
**The "Why":** Sending too much JavaScript to the browser increases the load time, execution time, and memory usage on the user's device. Reducing the bundle size is critical for users on slower networks or less powerful devices.

*   **Use Dynamic Imports:** For large components (like charts, heavy editors, or complex modals) that aren't needed immediately on page load, use `next/dynamic` or `React.lazy` to load them only when required.
*   **Favor Server Components (Next.js App Router):** Server Components execute entirely on the server and send zero JavaScript to the client. Default to Server Components unless you explicitly need interactivity (event listeners, state, lifecycle methods).

### 3. Server-Side Performance (Next.js)
**The "Why":** The server can process data faster and closer to the database. Leveraging Server Components (RSC) and server actions reduces the amount of work the client has to do.

*   **RSC by Default:** Only add `'use client'` at the leaves of your component tree. The root of your application and any data-fetching heavy components should ideally remain Server Components.
*   **Pass Data as Props, not Context:** When moving from Server to Client boundaries, pass the necessary data directly as props. This avoids needing to wrap your entire app in context providers which force everything into the client bundle.

### 4. State Management and Rendering
**The "Why":** Unnecessary re-renders slow down the UI. When state changes high up in the tree, React has to re-evaluate all child components.

*   **Keep state local:** Only lift state up when absolutely necessary. If a piece of state is only used by a single child component, it belongs in that child.
*   **Memoize expensive calculations:** Use `useMemo` for computationally expensive operations that shouldn't re-run on every render. Use `useCallback` to prevent re-creating function references unnecessarily (especially when passing them to memoized child components).

---

## Examples

### Example 1: Eliminating Data Waterfalls

**Anti-pattern (Sequential Fetching):**
```typescript
async function UserDashboard({ userId }) {
  // Waterfall! userProfile must finish before userPosts starts.
  const userProfile = await fetchProfile(userId);
  const userPosts = await fetchPosts(userId);

  return <Dashboard profile={userProfile} posts={userPosts} />;
}
```

**Recommended (Parallel Fetching):**
```typescript
async function UserDashboard({ userId }) {
  // Fetches start at the same time.
  const profilePromise = fetchProfile(userId);
  const postsPromise = fetchPosts(userId);

  const [userProfile, userPosts] = await Promise.all([
    profilePromise,
    postsPromise
  ]);

  return <Dashboard profile={userProfile} posts={userPosts} />;
}
```

### Example 2: React Server Components (RSC) vs Client Components

**Anti-pattern (Everything is a Client Component):**
```tsx
'use client' // Unnecessary 'use client' at the top level
import { useState, useEffect } from 'react';
import HeavyStaticSidebar from './HeavyStaticSidebar';

export default function Page() {
  const [data, setData] = useState(null);

  useEffect(() => {
    fetch('/api/data').then(res => res.json()).then(setData);
  }, []);

  return (
    <div className="flex">
      <HeavyStaticSidebar /> {/* This is now sent to the client! */}
      <main>{data ? <DataView data={data} /> : 'Loading...'}</main>
    </div>
  );
}
```

**Recommended (Isolate Interactivity):**
```tsx
// Page.tsx (Server Component)
import HeavyStaticSidebar from './HeavyStaticSidebar'; // Zero JS sent to client!
import InteractiveDataView from './InteractiveDataView';
import { fetchData } from '@/lib/api';

export default async function Page() {
  const data = await fetchData(); // Fetch on the server

  return (
    <div className="flex">
      <HeavyStaticSidebar />
      {/* Only the interactive part is a Client Component */}
      <main><InteractiveDataView initialData={data} /></main>
    </div>
  );
}
```
