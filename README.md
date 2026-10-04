# Catenary — Homebrew tap

The IDE for coding agents.
<https://thecatenary.app>

```sh
brew install --cask gionicolas/catenary/catenary
```

Upgrades: Catenary updates itself, so the cask is marked `auto_updates` and
`brew upgrade` leaves it alone. To force Homebrew to reinstall the latest
published version anyway:

```sh
brew upgrade --cask --greedy catenary
```

Uninstall, keeping your projects and settings:

```sh
brew uninstall --cask catenary
```

Add `--zap` to also remove application support files, caches and preferences.
