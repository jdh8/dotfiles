# Chen-Pang He's dotfiles

Here are my Un\*x configurations.

## GPG forwarding takeover

With the YubiKey plugged into the local computer, run this once for each remote
host after switching computers (or after a tunnel disconnects):

```sh
~/src/dotfiles/gpg-takeover.sh neihu.skymizer.com
~/src/dotfiles/gpg-takeover.sh dl02.skymizer.com
```

Sitting at the computer the key is now plugged into, run it with no argument:
it closes every forward in or out of this computer (the inbound one is an
`sshd-session` running nothing, which sshd would otherwise take the agent
socket down with) and starts the local agent on the card.

```sh
~/src/dotfiles/gpg-takeover.sh
```

Either way it writes the card's signature key as `user.signingkey` to
`~/.gitconfig.local` on this computer and on the remote host, so git signs
with whichever YubiKey is plugged in.

Tab-complete SSH hosts for it in bash:

```sh
ln -s ~/src/dotfiles/bash-completion/gpg-takeover.sh.bash ~/.local/share/bash-completion/completions/
```

## Claude Code

```sh
ln -s ~/src/dotfiles/CLAUDE.md ~/.claude/CLAUDE.md
mkdir -p ~/.claude/skills
for s in ~/src/dotfiles/skills/*/; do ln -s "${s%/}" ~/.claude/skills/; done
mkdir -p ~/.codex/skills
for s in ~/src/dotfiles/skills/*/; do ln -s "${s%/}" ~/.codex/skills/; done
```
