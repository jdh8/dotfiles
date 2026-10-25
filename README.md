Chen-Pang He's dotfiles
=======================
Here are my Un\*x configurations.

Claude Code
-----------
```sh
ln -s ~/src/dotfiles/CLAUDE.md ~/.claude/CLAUDE.md
mkdir -p ~/.claude/skills
for s in ~/src/dotfiles/skills/*/; do ln -s "${s%/}" ~/.claude/skills/; done
```
