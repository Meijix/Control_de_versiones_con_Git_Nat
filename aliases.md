# Aliases útiles de Git

Los aliases permiten crear atajos para comandos largos o frecuentes. Se guardan en `~/.gitconfig` (global) o en `.git/config` (por repositorio).

## Aliases recomendados

| Alias | Comando completo | Qué hace |
|-------|-------------------|----------|
| `st` | `status` | Estado del working tree |
| `co` | `checkout` | Cambiar de rama o restaurar archivos |
| `sw` | `switch` | Cambiar de rama (moderno) |
| `br` | `branch` | Listar o gestionar ramas |
| `ci` | `commit` | Crear un commit |
| `last` | `log -1 --oneline` | Ver el último commit |
| `lg` | `log --oneline --graph --decorate --all` | Historial visual compacto |
| `ll` | `log --pretty=format:'%C(yellow)%h%Creset %s %C(cyan)(%cr)%Creset %C(blue)<%an>%Creset' --graph` | Historial con colores, fecha relativa y autor |
| `unstage` | `restore --staged` | Quitar archivo del staging |
| `amend` | `commit --amend --no-edit` | Añadir cambios al último commit sin editar el mensaje |
| `graph` | `log --oneline --graph --all` | Grafo del historial |
| `aliases` | `config --get-regexp alias` | Listar todos los aliases configurados |
| `undo` | `reset HEAD~1 --mixed` | Deshacer último commit, conservar cambios |
| `wip` | `commit -am 'WIP'` | Commit rápido de trabajo en progreso |
| `branches` | `branch -a -v` | Listar todas las ramas con último commit |
| `remotes` | `remote -v` | Listar remotos configurados |
| `stash-all` | `stash push --include-untracked` | Guardar todo incluyendo archivos no rastreados |
| `diff-words` | `diff --word-diff` | Diff a nivel de palabra |

## Cómo instalarlos

### Uno por uno

```bash
git config --global alias.st "status"
git config --global alias.co "checkout"
git config --global alias.sw "switch"
git config --global alias.br "branch"
git config --global alias.ci "commit"
git config --global alias.last "log -1 --oneline"
git config --global alias.lg "log --oneline --graph --decorate --all"
git config --global alias.unstage "restore --staged"
git config --global alias.amend "commit --amend --no-edit"
git config --global alias.graph "log --oneline --graph --all"
git config --global alias.aliases "config --get-regexp alias"
git config --global alias.undo "reset HEAD~1 --mixed"
git config --global alias.branches "branch -a -v"
git config --global alias.remotes "remote -v"
git config --global alias.stash-all "stash push --include-untracked"
git config --global alias.diff-words "diff --word-diff"
```

### Todos de una vez (copiar en la terminal)

```bash
git config --global alias.st "status" && \
git config --global alias.co "checkout" && \
git config --global alias.sw "switch" && \
git config --global alias.br "branch" && \
git config --global alias.ci "commit" && \
git config --global alias.last "log -1 --oneline" && \
git config --global alias.lg "log --oneline --graph --decorate --all" && \
git config --global alias.unstage "restore --staged" && \
git config --global alias.amend "commit --amend --no-edit" && \
git config --global alias.graph "log --oneline --graph --all" && \
git config --global alias.aliases "config --get-regexp alias" && \
git config --global alias.undo "reset HEAD~1 --mixed" && \
git config --global alias.branches "branch -a -v" && \
git config --global alias.remotes "remote -v" && \
git config --global alias.stash-all "stash push --include-untracked" && \
git config --global alias.diff-words "diff --word-diff"
```

## Uso

Una vez configurados, se usan como cualquier comando de Git:

```bash
git st          # equivale a git status
git lg          # historial visual
git last        # último commit
git unstage archivo.txt  # quitar del staging
```

## Ver y eliminar aliases

```bash
# Ver todos los aliases configurados
git aliases

# Eliminar un alias
git config --global --unset alias.nombre
```

## Notas

- Los aliases **no reemplazan** el comando original; solo agregan un atajo.
- Si un alias tiene el mismo nombre que un comando de Git, el comando original tiene prioridad.
- Puedes definir aliases que ejecuten comandos de shell anteponiendo `!`: `git config --global alias.visual '!gitk --all'`.

## Referencias

- [Documentación de aliases en Git](https://git-scm.com/book/es/v2/Fundamentos-de-Git-Alias-de-Git)
