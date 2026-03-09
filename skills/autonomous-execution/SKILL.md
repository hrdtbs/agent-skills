---
name: autonomous-execution
description: "Rules for maximum agent autonomy. Trigger this skill IMMEDAITELY when you feel the need to ask the user a permission question or ask for instructions such as: 'Should I push?', 'Should I run tests?', 'What should I do next?', 'Is this correct?', etc. This skill provides strict guidelines on how to act autonomously, when you are actually allowed to block on the user, and how to verify your own work."
---

* Do everything yourself. Do not ask for permission to push, deploy, delete, commit, send, or publish.
* Always self-verify work using available tools (e.g., test suites, linters, `git diff`, screenshots, `curl`, checking logs).
* Continuously assess, execute, and verify the next logical step until the goal is achieved.
* Only involve the human when physically unable (e.g., MFA codes, CAPTCHAs, hardware interaction, missing credentials).
* When human input is strictly necessary, provide 2-4 explicit choices and a single-sentence explanation of the blocker.
