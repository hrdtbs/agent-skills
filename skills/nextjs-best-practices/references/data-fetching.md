# Data Fetching and Mutations in Next.js

The App Router drastically simplifies data fetching, caching, and state updates, bringing them closer to the server.

## 1. Fetching Data in Server Components

React Server Components (RSC) are asynchronous by default, eliminating the need for `useEffect` and `useState` for simple data retrieval. Use native `async`/`await` and the extended `fetch` API.

### `fetch` Deduplication

Next.js automatically dedupes identical `fetch` requests within the same render tree. This means you do not need to globally fetch data at the top of the tree and pass it down via props. You can fetch data directly where it's needed, improving component encapsulation.

```tsx
// ✅ Good: Fetch data locally in Server Components
import { getProduct } from '@/lib/db' // Example fetcher

export default async function ProductDetails({ id }: { id: string }) {
  const product = await getProduct(id)
  return <div>{product.name}</div>
}

export async function ProductRelatedList({ id }: { id: string }) {
  const product = await getProduct(id) // Same data, won't duplicate network request
  return <RelatedProducts category={product.category} />
}
```

### Static vs Dynamic Data

- **Static Rendering (Default):** The entire page (including its data fetching) is rendered at build time and served globally via CDN. This is highly performant.
- **Dynamic Rendering:** Data fetching happens at request time if you use dynamic functions (`cookies()`, `headers()`, `searchParams`) or explicitly opt out of caching.

### Cache Invalidations (`revalidate`)

Control the freshness of data fetching via `fetch` options:

```tsx
// Force refetch on every request
fetch('https://api.example.com/data', { cache: 'no-store' })

// Cache for a set duration (e.g., 60 seconds)
fetch('https://api.example.com/data', { next: { revalidate: 60 } })

// Revalidate based on a tag (can be triggered manually via Server Actions or API Routes)
fetch('https://api.example.com/data', { next: { tags: ['products'] } })
```

## 2. Server Actions for Mutations

Server Actions replace traditional REST APIs or GraphQL mutations, offering a type-safe RPC-like mechanism tightly integrated with React forms and transitions. They are the preferred way to mutate data in Next.js.

### Basic Usage

Use Server Actions directly in forms using the `action` attribute. This provides progressive enhancement (it works even before JavaScript loads).

```tsx
// app/actions.ts
'use server'

import { revalidatePath } from 'next/cache'

export async function createPost(formData: FormData) {
  const title = formData.get('title')
  const content = formData.get('content')

  // Example database call
  await db.post.create({ data: { title, content } })

  // Immediately purge the cache for the posts route
  revalidatePath('/posts')
}
```

```tsx
// app/posts/new/page.tsx (Server Component)
import { createPost } from '@/app/actions'

export default function NewPost() {
  return (
    <form action={createPost}>
      <input name="title" required />
      <textarea name="content" required />
      <button type="submit">Publish</button>
    </form>
  )
}
```

### Advanced Usage with `useTransition`

For complex interactions or inline mutations outside of forms, use `useTransition` to track loading states during Server Actions.

```tsx
// app/components/LikeButton.tsx (Client Component)
'use client'

import { useTransition } from 'react'
import { likePost } from '@/app/actions' // Server Action

export function LikeButton({ id }: { id: string }) {
  const [isPending, startTransition] = useTransition()

  return (
    <button onClick={() => startTransition(() => likePost(id))}>
      {isPending ? 'Liking...' : 'Like'}
    </button>
  )
}
```

## 3. Route Handlers (API Routes)

Route Handlers (`app/api/route.ts`) provide traditional REST endpoints. While Server Actions are preferred for interactions originating from within the Next.js app, Route Handlers remain crucial for webhooks, external integrations, or legacy code migrating to the App Router.

- Avoid Route Handlers for simple data fetching for components; use RSC instead.
- Use Route Handlers for tasks like exposing data to third parties.
