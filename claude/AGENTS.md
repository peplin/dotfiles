## Invariants

* Don't use excessive emoji in responses to me, in documentation or in code. I
    prefer minimalism over whimsy.
* Never perform git operations that interact with a remote, like `push` or `fetch`
* Never perform git operations that write unless explicitly instructed.
* Never create pull requests, for example by using the `gh pr create` CLI command. I will always create PRs by hand.
* Never add "Co-authored" by Claude to the description of any git commits

## Code Review

Use the /review skill for multi-persona code reviews.

## Python

* Prefer using pathlib instead of os.path
* Avoid unnecessary temporary variables, unless the code is particularly complex
    and would be hard to fit on 1-2 lines.
* Don't use f-strings with the Python logging library. Let the logging library
    itself handle string interpolation.

## Documentation

* Strive to write clear, self-documenting code. In docstrings for functions,
    don't describe in detail how the function does what it does, just explain the
    contract of the API for the user. Say "what" we're doing and why, not so
    much "how".


## Tools

* Use ripgrep (the `rg` CLI) for searching instead of grep
* Never run `bazel clean`

## Formatting and Linting

Don't run formatting or linting tools until the very end of your task.
For Python formatting, just run `ruff`. I have it installed on the PATH.

## Testing

When writing unit tests, prefer not to stub out internal implementation details.
It's OK in limited use but we should first consider if the code can be
refactored to support dependency injection.

Balance the scope of that refactoring against the number of mocks or stubs that
would be required. Be judicious in either approach.
