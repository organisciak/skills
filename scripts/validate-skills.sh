#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

if ! command -v rg >/dev/null 2>&1; then
  echo "error: ripgrep (rg) is required" >&2
  exit 2
fi

status=0

skill_files=()
while IFS= read -r skill_file; do
  skill_files+=("$skill_file")
done < <(find skills -mindepth 2 -maxdepth 2 -type f -name SKILL.md | sort)

if [ "${#skill_files[@]}" -eq 0 ]; then
  echo "error: no skill files found under skills/<skill-name>/SKILL.md" >&2
  exit 1
fi

echo "Found ${#skill_files[@]} skill(s)."

for skill_file in "${skill_files[@]}"; do
  skill_dir="$(dirname "$skill_file")"
  skill_name="$(basename "$skill_dir")"

  echo "Checking $skill_file"

  # Frontmatter boundaries
  first_line="$(sed -n '1p' "$skill_file")"
  second_delim_line="$(rg -n '^---$' "$skill_file" | sed -n '2p' | cut -d: -f1 || true)"

  if [ "$first_line" != "---" ] || [ -z "$second_delim_line" ]; then
    echo "  fail: missing valid YAML frontmatter delimiters"
    status=1
    continue
  fi

  # Extract frontmatter block (without delimiters)
  frontmatter="$(sed -n "2,$((second_delim_line - 1))p" "$skill_file")"

  # Required keys
  if ! printf '%s\n' "$frontmatter" | rg -q '^name:\s*.+$'; then
    echo "  fail: frontmatter missing required key 'name'"
    status=1
  fi

  if ! printf '%s\n' "$frontmatter" | rg -q '^description:\s*.+$'; then
    echo "  fail: frontmatter missing required key 'description'"
    status=1
  fi

  # Disallow extra keys beyond name/description
  extra_keys="$(printf '%s\n' "$frontmatter" | rg '^[A-Za-z0-9_-]+:' | rg -v '^(name|description):' || true)"
  if [ -n "$extra_keys" ]; then
    echo "  fail: unsupported frontmatter keys found (only name/description allowed):"
    printf '%s\n' "$extra_keys" | sed 's/^/    - /'
    status=1
  fi

  # Ensure folder name matches frontmatter name when present
  declared_name="$(printf '%s\n' "$frontmatter" | sed -n 's/^name:\s*//p' | head -n1 | tr -d '"' | tr -d "'" | xargs || true)"
  if [ -n "$declared_name" ] && [ "$declared_name" != "$skill_name" ]; then
    echo "  fail: frontmatter name '$declared_name' does not match folder '$skill_name'"
    status=1
  fi

  # Recommended metadata
  if [ ! -f "$skill_dir/agents/openai.yaml" ]; then
    echo "  warn: missing recommended file $skill_dir/agents/openai.yaml"
  fi

done

if [ "$status" -ne 0 ]; then
  echo "Validation failed."
  exit "$status"
fi

echo "Validation passed."
