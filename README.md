# Chen-Pang He's dotfiles

Here are my Un\*x configurations.

## GPG forwarding takeover

With the YubiKey plugged into the local computer, run this once for each remote
host after switching computers (or after a tunnel disconnects):

```sh
~/src/dotfiles/gpg-takeover.sh neihu.skymizer.com
~/src/dotfiles/gpg-takeover.sh dl02.skymizer.com
```

## Claude Code

```sh
ln -s ~/src/dotfiles/CLAUDE.md ~/.claude/CLAUDE.md
mkdir -p ~/.claude/skills
for s in ~/src/dotfiles/skills/*/; do ln -s "${s%/}" ~/.claude/skills/; done
mkdir -p ~/.codex/skills
for s in ~/src/dotfiles/skills/*/; do ln -s "${s%/}" ~/.codex/skills/; done
```
