---
name: supabase-postgres-best-practices
description: Postgres performance optimization and best practices from Supabase. Use this skill when writing, reviewing, or optimizing Postgres queries, schema designs, or database configurations.
license: MIT
metadata:
  author: supabase
  version: "1.1.0"
  organization: Supabase
  abstract: Comprehensive Postgres performance optimization guide for developers using Supabase and Postgres. Contains performance rules across 8 categories, prioritized by impact from critical (query performance, connection management) to incremental (advanced features). Each rule includes detailed explanations, incorrect vs. correct SQL examples, query plan analysis, and specific performance metrics to guide automated optimization and code generation.
---

# Supabase Postgres Best Practices

Comprehensive performance optimization guide for Postgres, maintained by Supabase.

## Flow Control Instructions

This skill contains rules across 8 categories, prioritized by impact to guide automated query optimization and schema design.

* When reviewing or optimizing a query, read `references/query-*.md` and `references/data-*.md`.
* When reviewing or designing a schema, read `references/schema-*.md`.
* When configuring connection pooling or reviewing connection errors, read `references/conn-*.md`.
* When working with Row-Level Security (RLS) or privileges, read `references/security-*.md`.
* When diagnosing lock contention or writing multi-step transactions, read `references/lock-*.md`.
* When monitoring performance or investigating slow queries, read `references/monitor-*.md`.
* When using advanced features like Full Text Search or JSONB, read `references/advanced-*.md`.
* To see the full list of sections and their impact, read `references/_sections.md`.

Do not attempt to infer Postgres best practices; strictly adhere to the guidelines provided in the reference files.
