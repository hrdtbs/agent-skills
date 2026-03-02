---
name: test-driven-development
description: Guidelines and procedures for Test-Driven Development (TDD).
---

* NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST.
* Write exactly one minimal test that defines the expected behavior. Test names must describe behavior, not implementation (e.g., `rejects empty email`).
* Run the test and verify it fails for the **expected reason** before writing any implementation code.
* Write the absolute minimum code required to make the test pass. Do not add future-proofing or refactor at this stage.
* Verify the test (and all others) passes.
* Refactor only when tests are green.
