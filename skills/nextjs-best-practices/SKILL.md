---
name: nextjs-best-practices
description: Use this skill whenever the user mentions Next.js, App Router, Server Components, Server Actions, or Next.js performance optimizations. It provides comprehensive guidelines for building modern Next.js applications using the App Router, covering server vs client components, data fetching patterns, and optimization strategies. Don't use this for Pages Router or non-Next.js React apps.
---

# Next.js App Router Best Practices

This skill provides comprehensive guidelines and best practices for developing modern web applications using the Next.js App Router.

## Core Directives

1. **Embrace Server-First Development:** Default to React Server Components (RSC). They improve performance by keeping heavy dependencies on the server and reducing client-side JavaScript. Only move to Client Components when interactivity or browser APIs are required.
2. **Optimize Data Fetching:** Leverage Next.js caching and revalidation patterns. Fetch data where it's used, avoiding prop drilling, as Next.js automatically dedupes `fetch` requests in Server Components.
3. **Use Server Actions for Mutations:** Prefer Server Actions over traditional API routes for form submissions and data mutations. They provide a seamless, type-safe RPC-like mechanism tightly integrated with React's form lifecycle.
4. **Colocate Files:** Keep components, styles, tests, and localized utilities close to their routes. The App Router's directory structure naturally supports this pattern, keeping feature logic modular.

## References

Consult the following reference documents for detailed guidelines on specific areas of Next.js App Router development:

- [Server Components](./references/server-components.md): Deep dive into the Server vs Client component paradigms, when to use `"use client"`, and composition patterns.
- [Data Fetching](./references/data-fetching.md): Comprehensive patterns for `fetch`, Server Actions, Route Handlers, and cache invalidation strategies.
- [Routing](./references/routing.md): Advanced routing techniques, including layouts, parallel routes, intercepting routes, and loading/error states.

## General Development Workflow

When starting a new Next.js feature or diagnosing an issue, follow these steps:

1. **Architecture:** Determine the component boundaries. Start with a Server Component at the page level. Identify exactly which interactive pieces need to be Client Components and push the `"use client"` directive as far down the tree as possible.
2. **Data Fetching:** Decide where data needs to be fetched. If multiple components need the same data, fetch it in the highest necessary Server Component or fetch it in both places (relying on Next.js deduplication if using `fetch`).
3. **State Management:** For UI state, use React Context or local state in Client Components. For URL-driven state (search params, pagination), prefer keeping it in the URL so Server Components can access it.
4. **Mutations:** Create a Server Action for data updates. Integrate it with `useTransition` or the `<form action={...}>` attribute for seamless progressive enhancement and loading states.
5. **Review:** Ensure that sensitive information (API keys, database credentials) remains securely on the server and is not inadvertently leaked through Client Component props.
