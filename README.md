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
