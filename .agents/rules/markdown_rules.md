# Markdown Formatting & Linter Rules

- **Blank Lines Surrounding Lists (MD031 / MD032)**: Always ensure lists are surrounded by a blank line before the first bullet item and a blank line after the last bullet item.
- **Tight Lists (No `<p>` inside `<li>`)**: Bullet items within the same list block must be adjacent without blank lines between them, ensuring Hugo generates clean `<li>text</li>` elements instead of loose lists with `<p>` tags.
- **Ingredients Subtitles**: Subheadings inside `## Ingredients` (e.g., `### Dressing`, `### Optional Spices`) must be formatted as `### Subheadings` without bullet points.
- **Trailing Newlines (MD047)**: Every `.md` file must end with exactly one trailing newline character (`\n`).
- **No Trailing Whitespace (MD009)**: Strip trailing spaces from the end of lines.
