# React Server Components (RSC) vs Client Components

Next.js App Router defaults to Server Components, providing a fundamental shift in how React applications are built. This reference outlines best practices for working with both paradigms.

## The Mental Model

- **Server Components (Default):** Rendered *exclusively* on the server. They have direct access to backend resources (databases, file systems) and do not add to the client-side JavaScript bundle.
- **Client Components (`"use client"`):** Rendered on the server (for initial HTML) *and* hydrated on the client. They support interactivity, browser APIs, and state (`useState`, `useEffect`).

## When to Use Which

| Use Case | Server Component | Client Component |
| :--- | :---: | :---: |
| Fetch data | ✅ | ❌ (Unless SWR/React Query is needed) |
| Access backend resources directly | ✅ | ❌ |
| Keep large dependencies on the server | ✅ | ❌ |
| Add interactivity (`onClick`, `onChange`) | ❌ | ✅ |
| Use State and Lifecycle Effects | ❌ | ✅ |
| Use browser-only APIs | ❌ | ✅ |

## Composition Best Practices

### 1. Push Client Components Down the Tree

To minimize the JavaScript bundle size, define the `"use client"` boundary as far down the component tree as possible. If a page has a static layout but an interactive button, only the button should be a Client Component.

```tsx
// ❌ Bad: Entire page is a Client Component
"use client"
import { useState } from 'react'

export default function Page() {
  const [open, setOpen] = useState(false)
  return (
    <div>
      {/* Huge static content chunk */}
      <button onClick={() => setOpen(true)}>Open</button>
    </div>
  )
}

// ✅ Good: Only the interactive part is a Client Component
import { DialogButton } from './dialog-button' // "use client" in here

export default function Page() {
  return (
    <div>
      {/* Huge static content chunk stays a Server Component */}
      <DialogButton />
    </div>
  )
}
```

### 2. Passing Server Components to Client Components as Children

You cannot import a Server Component directly into a Client Component. Instead, pass the Server Component as a `children` prop (or another prop) from a parent Server Component. This allows Next.js to render the Server Component before the Client Component hydrates.

```tsx
// app/layout.tsx (Server Component)
import { Navigation } from './navigation' // Client Component
import { UserProfile } from './user-profile' // Server Component

export default function Layout({ children }) {
  return (
    <Navigation>
      <UserProfile /> {/* ✅ Good: Passed as children */}
    </Navigation>
  )
}
```

```tsx
// app/navigation.tsx (Client Component)
"use client"
import { useState } from 'react'

export function Navigation({ children }: { children: React.ReactNode }) {
  const [isOpen, setIsOpen] = useState(false)
  return (
    <nav>
      <button onClick={() => setIsOpen(!isOpen)}>Toggle</button>
      {isOpen && children}
    </nav>
  )
}
```

### 3. Server-Only Code

Use the `server-only` package to explicitly mark utility functions or files that should never be executed on the client, preventing accidental leaks of environment variables or backend logic.

```bash
npm install server-only
```

```typescript
// lib/db.ts
import 'server-only'

export async function getDatabaseConnection() { ... }
```
