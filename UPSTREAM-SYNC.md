# Syncing with Upstream (Jeff Geerling's Repository)

This fork is based on [geerlingguy/mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook). This document explains how to keep your fork up-to-date with Jeff's latest improvements while preserving your personal customizations.

## Architecture Overview

This playbook uses a clean separation between upstream defaults and personal customizations:

- **`default.config.yml`** - Jeff's baseline configuration (tracked in git, synced from upstream)
- **`config.yml`** - Your personal configuration (git-ignored, never committed)
- **`main.yml`** - Main playbook (tracked in git, synced from upstream)

Your `config.yml` overrides any values in `default.config.yml`, so upstream updates won't affect your personal settings.

## One-Time Setup

The upstream remote has already been configured, but if you need to set it up again or on a different machine:

```bash
# Add upstream remote (only needed once)
git remote add upstream https://github.com/geerlingguy/mac-dev-playbook.git

# Verify remotes
git remote -v
```

You should see:
- `origin` - Your fork (jeffduska/mac-dev-playbook)
- `upstream` - Jeff's original repository

## Future Upstream Updates (Simple Workflow)

Whenever you want to pull in Jeff's latest improvements, follow these steps:

### 1. Fetch Upstream Changes

```bash
git fetch upstream master
```

### 2. Check What's New (Optional but Recommended)

```bash
# See list of new commits
git log HEAD..upstream/master --oneline

# See which files changed
git diff HEAD...upstream/master --stat

# See detailed changes to default config
git diff HEAD upstream/master -- default.config.yml
```

### 3. Merge Upstream Changes

```bash
git merge upstream/master
```

Most of the time this will be a fast-forward merge with no conflicts, since your customizations are in the ignored `config.yml`.

### 4. Push to Your Fork

```bash
git push origin master  # or your current branch name
```

## Quick One-Liner

For experienced users, you can combine the steps:

```bash
git fetch upstream master && \
git merge upstream/master && \
git push origin master
```

Or use `--ff-only` to ensure the merge is conflict-free:

```bash
git fetch upstream master && \
git merge upstream/master --ff-only && \
git push origin master
```

## Handling Merge Conflicts (Rare)

If you've modified tracked files (not recommended), you might encounter conflicts:

### Option A: Rebase (Cleaner History)

```bash
git fetch upstream master
git rebase upstream/master

# If conflicts occur:
# 1. Resolve conflicts in the listed files
# 2. Stage the resolved files: git add <file>
# 3. Continue: git rebase --continue

# After successful rebase:
git push origin master --force-with-lease
```

### Option B: Merge (Preserves History)

```bash
git fetch upstream master
git merge upstream/master

# If conflicts occur:
# 1. Resolve conflicts in the listed files
# 2. Stage the resolved files: git add <file>
# 3. Complete merge: git commit

# Push the merge:
git push origin master
```

## Best Practices

### Do's ✅

- **Keep customizations in `config.yml`** - This file is git-ignored and will never conflict
- **Sync regularly** - Monthly syncs are easier than yearly ones
- **Review changes before merging** - Use `git log` and `git diff` to see what's new
- **Test after updates** - Run the playbook with `--check` mode first
- **Document manual steps** - Keep your own `full-mac-setup.md` for environment-specific notes

### Don'ts ❌

- **Don't modify `default.config.yml`** - Override values in `config.yml` instead
- **Don't commit `config.yml`** - It's personal and should stay git-ignored
- **Don't modify core playbook files** - If you need custom tasks, use `post_provision_tasks`
- **Don't skip testing** - Always test updates before deploying to production machines

## Subscribing to Upstream Updates

To get notified of upstream changes:

1. Go to https://github.com/geerlingguy/mac-dev-playbook
2. Click "Watch" → "Custom" → "Releases"
3. Or use GitHub's RSS feed: https://github.com/geerlingguy/mac-dev-playbook/commits/master.atom

## Troubleshooting

### "Already up to date" but you know there are changes

```bash
# Verify you're on the right branch
git branch

# Check your current commit vs upstream
git log --oneline --graph --decorate --all | head -20

# Force fetch
git fetch upstream master --force
```

### Accidentally committed config.yml

```bash
# Remove from git but keep the file
git rm --cached config.yml
git commit -m "Remove config.yml from git tracking"
git push origin master
```

### Want to see what Jeff changed in a specific file

```bash
# See history of a specific file in upstream
git log upstream/master -- default.config.yml

# See changes in a specific commit
git show <commit-hash>
```

## Sync History

Keep track of when you last synced:

- **2025-11-05**: Synced to commit `719de35` - Added Dependabot, updated GitHub Actions, fixed mas conditionals

---

**Last Updated**: 2025-11-05
**Upstream Repository**: https://github.com/geerlingguy/mac-dev-playbook
**Upstream Author**: Jeff Geerling
