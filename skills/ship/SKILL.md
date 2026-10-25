---
name: ship
description: Release a crate/package in the safe order — verify version, push and wait for CI, tag a GitHub release, then publish to the immutable registry (crates.io). Use when the user says "ship", "/ship", "cut a release", "publish this version", or "release X.Y.Z".
---

# ship

Order matters: GitHub is fixable, crates.io is forever. Never publish before CI is green.

## 1. Version is releasable

- Read the version from the manifest (`Cargo.toml`, `package.json`, ...).
- Reject `-dev`, `-alpha`, `-rc`, or anything not a clean release version. Ask the user for the real version and set it.
- CHANGELOG has an entry for this version, not "Unreleased". Fix it if not.
- Working tree clean; `cargo publish --dry-run` (or `npm pack`) passes.
- Version must not already exist on the registry — check before doing anything else.

## 2. Push and wait for CI

```
git push
gh run watch $(gh run list -b <branch> -L1 --json databaseId -q '.[0].databaseId') --exit-status
```

CI red → stop, report, fix. Do not continue.

## 3. GitHub release

Tag is the bare version, **no `v` prefix**:

```
gh release create 1.3.0 --title 1.3.0 --notes "<this version's CHANGELOG section>"
```

## 4. Registry (irreversible)

Only after 1–3 all succeeded:

```
cargo publish
```

Ask the user to confirm before this step unless they already said to go all the way.

## After

Bump the manifest to the next `-dev` version if that's the repo's habit (check git log), commit, push.
