#!/bin/sh
# Run on the computer holding the YubiKey, with one remote SSH host as argument.
set -eu

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [user@]host" >&2
    exit 2
fi
host=$1
case "$host" in
    ''|-*) echo "Expected an SSH host, not an option." >&2; exit 2 ;;
esac

gpgconf --launch gpg-agent
local_socket=$(gpgconf --list-dirs agent-extra-socket)
if [ ! -S "$local_socket" ]; then
    echo "GPG extra socket is unavailable: $local_socket" >&2
    exit 1
fi

# A separate master lets takeover restart GPG forwarding without closing shells.
control=$(ssh -G -T -S "$HOME/.ssh/gpg-forward-%C" "$host" |
    awk '$1 == "controlpath" { print substr($0, 13); exit }')
test -n "$control"
ssh -F /dev/null -S "$control" -O exit "$host" 2>/dev/null || :
ssh -MNf -S "$control" -o ClearAllForwardings=yes -o ControlPersist=no \
    -o ServerAliveInterval=30 -o ServerAliveCountMax=3 "$host"
trap 'ssh -F /dev/null -S "$control" -O exit "$host" >/dev/null 2>&1 || :' 0
trap 'exit 1' HUP INT TERM

remote_socket=$(ssh -T -S "$control" -o ClearAllForwardings=yes "$host" sh -s <<'REMOTE'
set -eu
umask 077
if command -v gpgconf >/dev/null 2>&1; then
    gpgconf --create-socketdir
    socket=$(gpgconf --list-dirs agent-socket)
elif [ -d "/run/user/$(id -u)" ]; then
    socket="/run/user/$(id -u)/gnupg/S.gpg-agent"
else
    socket="$HOME/.gnupg/S.gpg-agent"
fi
case "$socket" in
    /*/S.gpg-agent) ;;
    *) echo "Unexpected remote GPG socket: $socket" >&2; exit 1 ;;
esac
mkdir -p "${socket%/*}"
if [ -e "$socket" ] || [ -L "$socket" ]; then
    if [ ! -S "$socket" ] || [ -L "$socket" ]; then
        echo "Refusing to replace a non-socket or symlink: $socket" >&2
        exit 1
    fi
    rm -- "$socket"
fi
printf '%s\n' "$socket"
REMOTE
)

# Ignore configured forwards here: only add the dynamically discovered GPG route.
ssh -F /dev/null -S "$control" -O forward \
    -R "$remote_socket:$local_socket" "$host"
trap - 0 HUP INT TERM
printf 'GPG forwarding: %s:%s -> %s\n' "$host" "$remote_socket" "$local_socket"
