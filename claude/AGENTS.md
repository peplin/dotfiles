## Invariants

* Don't use excessive emoji in responses to me, in documentation or in code. I
    prefer minimalism over whimsy.
* Never perform git operations that interact with a remote, like `push` or `fetch`
* Never create pull requests, for example by using the `gh pr create` CLI command. I will always create PRs by hand.
* Never add "Co-authored" by Claude to the description of any git commits

## Python

* Prefer using pathlib instead of os.path
* Avoid unnecessary temporary variables, unless the code is particularly complex
    and would be hard to fit on 1-2 lines.

## Tools

* Use ripgrep (the `rg` CLI) for searching instead of grep

## Formatting and Linting

Don't run formatting or linting tools until the very end of your task.
For Python formatting, just run `ruff`. I have it installed on the PATH.
