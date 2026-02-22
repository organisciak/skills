# AGENTS.md

## Repository Scope

This repository is a general-purpose skills monorepo. It stores reusable skills that can be consumed across different agent runtimes and projects.

## Canonical Structure

All skills must live under:

- `skills/<skill-name>/`

Each skill directory must contain:

- `SKILL.md`

Each skill directory should usually contain:

- `agents/openai.yaml`

Optional directories (only when needed):

- `references/`
- `scripts/`
- `assets/`

## Skill Naming

- Use lowercase letters, digits, and hyphens only.
- Keep names short and action/domain clear.
- Folder name must match `name` in `SKILL.md` frontmatter.

## SKILL.md Contract

`SKILL.md` must start with YAML frontmatter and include only:

- `name`
- `description`

Do not add extra frontmatter keys.

Body guidance:

- Keep instructions procedural and concise.
- Keep core workflow in `SKILL.md`.
- Move bulky detail, examples, and domain tables into `references/`.
- Link to references from `SKILL.md` instead of duplicating content.

## agents/openai.yaml Contract

When present, include interface metadata only as needed for UI use:

- `interface.display_name`
- `interface.short_description`
- `interface.default_prompt`

Keep values consistent with `SKILL.md` intent.

## Editing and Review Rules

- Keep edits scoped to the skill(s) requested.
- Do not rename skill folders unless migration is requested.
- Do not add auxiliary docs inside skill folders unless directly used by the skill.
- Prefer reusable scripts over repeating complex inline command blocks.

## Validation

Run before commit or publish:

```bash
./scripts/validate-skills.sh
```

A change is not ready if validation fails.

## Publishing Guidance

- Treat this repo as canonical source for skills.
- Publish/distribute per skill folder as needed.
- Keep migration and remote-management notes in top-level `PUBLISHING.md`.

## Landing the Plane (Session Completion)

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd sync
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds
