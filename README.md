# Holo

aka Nicolai's dotfiles.
Named after [the wise wolf](https://myanimelist.net/character/7373/Holo/) since it knows the truth about my configs (or sth like that).

## Setup

```shell
sudo pacman -S chezmoi #or whatever you package manager is
chezmoi init git@github.com:nicolaiort/holo.git
chezmoi diff #to see what would get overwritten
chezmoi apply #to apply the diff (if that's fine with you)

chezmoi cd #cds into the git repo this is actually tracking
chezmoi update #runs git pull and apply
```

## Declarative package baselines

All package managers are managed declaratively via lists in `packages/`
(`.chezmoiignore` keeps them from being deployed to `~`).
Each manager has one list plus a `run_onchange_before_*.sh.tmpl` script
that runs automatically with `chezmoi apply` whenever its list changes.

| Manager | List | Script | Content |
|---|---|---|---|
| yay (pacman+AUR) | `packages/yay.txt` (+ `yay.<hostname>.txt`, see below) | `run_onchange_before_10-install-yay.sh.tmpl` | 144 packages, grouped by use |
| flatpak (flathub, system) | `packages/flatpak.txt` | `run_onchange_before_20-install-flatpak.sh.tmpl` | apps only, flatpak resolves runtimes |
| krew | `packages/krew.txt` | `run_onchange_before_30-install-krew.sh.tmpl` | kubectl plugins, incl. bootstrap |
| volta | `packages/volta.txt` | `run_onchange_before_40-install-volta.sh.tmpl` | `tool@version`, incl. bootstrap |
| Go tools | `packages/gotools.txt` | `run_onchange_before_50-install-gotools.sh.tmpl` | `path@version`, version-checked via `go version -m` |
| VS Code | `packages/vscode-extensions.txt` | `run_onchange_before_60-install-vscode-extensions.sh.tmpl` | extension IDs |
| bun | `packages/bun-version.txt` | `run_onchange_before_70-install-bun.sh.tmpl` | exactly one version, upstream installer |

Principles:

- **Install-only**: scripts only install what's missing, never uninstall.
  Removing an entry leaves the package installed (makes cleanup safe).
- **Presence over version**: "installed" counts, not "up to date"
  (exceptions: gotools checks the version, bun is pinned exactly).
  Upgrades go through the native routes (`yay -Syu`, `kubectl krew upgrade`, …).
- **Short status**: each script prints `X baseline: HAVE/TOTAL up to date`,
  plus one line only when something actually gets installed.
- **Bootstrap**: if the tool itself is missing, the script installs it
  (yay, krew, volta) or skips with a note (go, code).

Workflow: edit the matching list, run `chezmoi apply`
(test with `chezmoi apply --dry-run --verbose`; real runs need
sudo/polkit, so use an interactive terminal).

Stay manual (no package available): `kubeone` in `/usr/local/bin`
(see comment in `yay.txt`), `~/.t3` (duplicates AUR `t3code-bin`),
`~/.unsloth`, `~/.local/bin/vox-opencode`.

## Templating templates for templating

### Single Computer

```gotemplate
{{ if eq .chezmoi.hostname "nicolai-xps9320" }}
{{ end }}
```

### If Else computer

```gotemplate
{{ if eq .chezmoi.hostname "blackpanther" }}
{{ else if eq .chezmoi.hostname "nicolai-xps9320" }}
{{ end }}
```

### Host-specific packages (yay)

`packages/yay.txt` applies to all hosts. If
`packages/yay.<hostname>.txt` additionally exists (e.g. `packages/yay.blackpanther.txt`),
it gets installed on top — e.g. for the Nvidia driver
(`nvidia-open-dkms`, `libva-nvidia-driver`, `onnxruntime-cuda`), which does not
belong on every machine. Hosts without their own file only get the base.
The script `run_onchange_before_10-install-yay.sh.tmpl` runs automatically when
either of the two files changes (`run_onchange_before`).
