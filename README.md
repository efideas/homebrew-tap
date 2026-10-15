# efideas Homebrew tap

Homebrew casks for [efideas](https://github.com/efideas) projects.

## Install

```bash
brew install --cask efideas/tap/claude-switcher
```

`efideas/tap` resolves to this repository (`efideas/homebrew-tap`), so no separate `brew tap` is needed.

## Casks

| Cask | Project |
| --- | --- |
| `claude-switcher` | [Claude Switcher](https://github.com/efideas/claude-switcher), a launcher that opens several Claude Desktop instances, one per account |

## Updating a cask

`claude-switcher` is updated automatically: publishing a release in [efideas/claude-switcher](https://github.com/efideas/claude-switcher) runs its `update-cask` workflow, which rewrites `version` and both `sha256` values here and pushes to `main`.

To bump a cask by hand (or if the workflow fails):

1. Publish the new release in the project repository.
2. Bump `version` in `Casks/<name>.rb`.
3. Replace both `sha256` values with the checksums of the new `.dmg` files (`shasum -a 256 <file>`).
4. Run `brew audit --cask --tap efideas/tap <name>` and `brew style Casks/<name>.rb`, then push.
