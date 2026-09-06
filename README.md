# Catenary — Homebrew tap

The infinite canvas where your coding agents are wired together.
<https://thecatenary.app>

```sh
brew tap gionicolas/catenary
brew trust gionicolas/catenary
brew install --cask catenary
```

Or in one line:

```sh
brew trust --cask gionicolas/catenary/catenary
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
