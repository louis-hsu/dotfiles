# Skill sets repo

## Workflow
1. Fork original skill repo and change default branch to 'myskills'
2. Clone the forked repo to `~/.dotfiles/agent-skills/`
3. Install skill set by `npx skills add`

## Skill installation
### Example 
`npx skills add ~/.dotfiles/agent-skills/vercel-skills -g -a claude-code`

### Explanation
- `-g / —global`
	Controls scope — where the skills are installed:

	* `-g` → installs to your home directory (`~/.agents/skills/`), available across all projects
	* Without `-g` → installs to the current working directory (`./.agents/skills/`), project-local only

- `-a / --agent`
	Controls which agent gets the symlink created:

	* `-a claude-code` → creates symlink in `~/.claude/skills/`
	* `-a cursor` → creates symlink in `~/.cursor/skills/`
	* `-a '*'` → symlinks into every detected agent's directory
	* Can be specified multiple times: `-a claude-code -a cursor`
	* Without `-a` → CLI auto-detects which agents you have installed and sets up all of them


Other useful flags
| Flag | Meaning |
|:----|:----|
| `--skill <name>` / `-s` | Install only specific skill(s) from the repo instead of all |
| `--skill '*'` | Explicitly install all skills |
| `—-list` / `-l` | Preview what skills a repo contains without installing |
| `—-yes` / `-y` | Skip all confirmation prompts (good for scripting/dotfiles bootstrap) |
| `—-copy` | Copy files instead of symlinking - use if symlinks cause issues |
| `—-all` | Install to all agents without being prompted |
