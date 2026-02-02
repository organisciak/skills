# Publishing Instructions

Your Outlook Web plugin is ready to publish! Follow these steps:

## Directory Structure (Already Created ✓)

```
outlook-web-skill/
├── .claude-plugin/
│   └── plugin.json          # Plugin metadata
├── skills/
│   └── outlook-web/
│       ├── SKILL.md         # Main skill file
│       ├── OPTIMIZATION-AUDIT.md
│       └── references/
│           └── ui-patterns.md
├── README.md                # Repository README
├── LICENSE                  # MIT License
└── .gitignore              # Git ignore rules
```

## Step 1: Create GitHub Repository

1. Go to [github.com/new](https://github.com/new)

2. **Repository settings:**
   - **Name**: `outlook-web-skill`
   - **Description**: "Claude Code plugin for Outlook Web automation via playwright-cli"
   - **Visibility**: Public (required for marketplace)
   - **Initialize**: Don't add README, license, or .gitignore (we already have them)

3. Click **Create repository**

## Step 2: Push Your Plugin Code

From the `outlook-web-skill` directory:

```bash
# Navigate to the plugin directory
cd /Users/peter.organisciak/Downloads/playwright-cli-test/outlook-web-skill

# Initialize git
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial release: Outlook Web plugin v1.0.0

Features:
- Email operations (read, compose, reply, search)
- Calendar viewing (day/week/month)
- Session management with persistent auth
- Optimized text extraction for LLMs (70-90% token reduction)
- Batch operations and resource blocking options"

# Add remote (replace 'organisciak' with your GitHub username)
git remote add origin https://github.com/organisciak/outlook-web-skill.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Step 3: Create a Release (Recommended)

1. Go to your repository: `https://github.com/organisciak/outlook-web-skill`

2. Click **Releases** → **Create a new release**

3. **Tag**: `v1.0.0`

4. **Title**: `v1.0.0 - Initial Release`

5. **Description**:
```markdown
## Features

✨ Initial release of the Outlook Web plugin for Claude Code!

### Email Operations
- 📧 Read inbox and individual emails
- ✍️ Compose drafts (safe by default)
- ↩️ Reply to and forward emails
- 🔍 Search emails
- 📁 Navigate folders

### Calendar
- 📅 View calendar (day/week/month)
- 📆 See upcoming events
- 🕒 Check availability

### Performance
- ⚡ 60-70% faster with batch operations
- 🎯 70-90% token reduction with text extraction
- 💾 Persistent session management

### Requirements
- Claude Code CLI
- playwright-cli plugin

See README.md for installation and usage instructions.
```

6. Click **Publish release**

## Step 4: Users Can Now Install!

Once published, users can install via marketplace:

```bash
/plugin marketplace add organisciak/outlook-web-skill
/plugin install outlook-web
/outlook-web check my inbox
```

Or manually:

```bash
mkdir -p ~/.claude/skills/outlook-web
curl -o ~/.claude/skills/outlook-web/SKILL.md \
  https://raw.githubusercontent.com/organisciak/outlook-web-skill/main/skills/outlook-web/SKILL.md
```

## Step 5: Announce (Optional)

Share your plugin:

1. **Claude Code Community**:
   - Post in Claude Code discussions/forums
   - Share on social media with #ClaudeCode

2. **Add Topics to GitHub**:
   - Go to your repo → About → ⚙️ Settings
   - Add topics: `claude-code`, `outlook`, `automation`, `playwright`, `email`

3. **Create a Demo**:
   - Add screenshots or GIF demos to README.md
   - Record a quick video showing the skill in action

## Updating Your Plugin

When you make changes:

1. **Update version** in `.claude-plugin/plugin.json`:
   ```json
   "version": "1.1.0"
   ```

2. **Commit and push**:
   ```bash
   git add .
   git commit -m "Version 1.1.0: Add new features"
   git push
   ```

3. **Create new release** on GitHub with the new version tag

4. **Users update** with:
   ```bash
   /plugin marketplace update
   /plugin upgrade outlook-web
   ```

## Troubleshooting

### Repository is private
The repository **must be public** for Claude Code marketplace to access it. Change visibility in:
- Settings → Danger Zone → Change repository visibility

### Plugin not found
- Verify the repository URL is correct
- Check that `.claude-plugin/plugin.json` exists
- Ensure the repository is public

### Installation fails
- Verify all file paths are correct (case-sensitive)
- Check that SKILL.md has proper frontmatter
- Test locally first with: `claude --plugin-dir /path/to/outlook-web-skill`

## Testing Before Publishing

Test locally before pushing:

```bash
# Test the plugin locally
claude --plugin-dir /Users/peter.organisciak/Downloads/playwright-cli-test/outlook-web-skill

# In Claude Code CLI:
/outlook-web check inbox
```

## Support

After publishing, monitor:
- GitHub Issues for bug reports
- GitHub Discussions for questions
- Pull Requests for contributions

## Next Steps

1. ✅ Push to GitHub (see Step 2)
2. ✅ Create release (see Step 3)
3. ✅ Test installation yourself
4. 📢 Announce to community
5. 🔄 Iterate based on feedback

---

**Ready to publish?** Start with Step 1 above!
