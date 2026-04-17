## Invariants

* Don't use excessive emoji in responses to me, in documentation or in code. I
    prefer minimalism over whimsy.
* Never perform git operations that interact with a remote, like `push` or `fetch`
* Never perform git operations that write unless explicitly instructed.
* Never create pull requests, for example by using the `gh pr create` CLI command. I will always create PRs by hand.
* Never add "Co-authored" by Claude to the description of any git commits

## Approach

* Prefer small, incremental changes that minimize blast radius. When a change
    could balloon into touching many files or pulling in many codeowners,
    surface that tradeoff and look for a narrower shape first (e.g. pin a
    minor version back to avoid a reformat, split a bump from a reformat,
    grandfather existing files rather than rewriting them).
* When investigating a pre-existing gate, check, or defensive guard, read the
    git log and the introducing PR before removing or weakening it. The
    original rationale often explains a non-obvious constraint that still
    applies.

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
* Don't use non-ASCII characters like `—`
* Avoid overuse of emdash in ways that break up the flow of a sentence. Prefer
    to rewrite for better flow, or just use separate sentences.
* When writing Markdown doc files, wrap lines at 80 characters.


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

When running tests, prefer using `bazel test //path/to/package/...` or `bazel
test //path/to/package:target` - don't try to run the tests manually out of
the Bazel runfiles.

For sanity checks on a change (e.g. confirming a Bazel macro or lint rule
works), pick one narrow target (like `//pkg:foo_lint_py311`), not a
wildcard. If the wildcard expands to more than a handful of targets, the
test is the wrong scope for the question you are actually asking.

Don't pipe long-running background Bazel commands through `tail` or `head`.
Those tools buffer until the input stream closes, so nothing surfaces until
the command completes. Write the full output to a file and inspect it
directly, or use a narrower scope that finishes quickly in the foreground.
