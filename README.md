# Holo

aka Nicolai's dotfiles.

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
