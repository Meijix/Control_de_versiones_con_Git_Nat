# Hoja de referencia rapida de Git

## Configuracion

| Comando | Que hace |
|---------|----------|
| `git config --global user.name "Nombre"` | Establece el nombre del autor para todos los repositorios |
| `git config --global user.email "correo@ejemplo.com"` | Establece el correo del autor para todos los repositorios |
| `git config --global core.editor "code --wait"` | Define el editor de texto por defecto |
| `git config --global init.defaultBranch main` | Cambia el nombre de la rama inicial a `main` |
| `git config --list` | Muestra toda la configuracion activa |

## Flujo basico

| Comando | Que hace |
|---------|----------|
| `git init` | Inicializa un repositorio nuevo en la carpeta actual |
| `git add <archivo>` | Agrega un archivo al area de preparacion (staging) |
| `git add -A` | Agrega todos los cambios (nuevos, modificados y eliminados) al staging |
| `git commit -m "mensaje"` | Crea un commit con los cambios en staging |
| `git commit --amend` | Modifica el ultimo commit (mensaje o contenido) |
| `git status` | Muestra el estado del working tree y del staging |
| `git log --oneline` | Muestra el historial de commits en formato compacto |
| `git log --oneline --graph --all` | Muestra el historial con grafo de todas las ramas |
| `git diff` | Muestra diferencias entre working tree y staging |
| `git diff --staged` | Muestra diferencias entre staging y el ultimo commit |

## Ramas

| Comando | Que hace |
|---------|----------|
| `git branch` | Lista las ramas locales |
| `git branch -a` | Lista ramas locales y remotas |
| `git branch <nombre>` | Crea una rama nueva sin cambiarse a ella |
| `git branch -d <nombre>` | Elimina una rama local (seguro: solo si ya fue fusionada) |
| `git branch -D <nombre>` | Elimina una rama local de forma forzada |
| `git switch <nombre>` | Cambia a una rama existente |
| `git switch -c <nombre>` | Crea una rama nueva y cambia a ella |
| `git merge <rama>` | Fusiona `<rama>` en la rama actual |
| `git merge --abort` | Cancela un merge en progreso con conflictos |
| `git rebase <rama>` | Reaplica los commits de la rama actual sobre `<rama>` |
| `git rebase --abort` | Cancela un rebase en progreso |
| `git rebase --continue` | Continua el rebase despues de resolver un conflicto |

## Remotos

| Comando | Que hace |
|---------|----------|
| `git clone <url>` | Clona un repositorio remoto en una carpeta local |
| `git remote -v` | Muestra los remotos configurados con sus URLs |
| `git remote add <nombre> <url>` | Agrega un remoto con el alias indicado |
| `git remote remove <nombre>` | Elimina un remoto |
| `git fetch` | Descarga commits y referencias del remoto sin fusionar |
| `git fetch --prune` | Descarga del remoto y limpia referencias de ramas eliminadas |
| `git pull` | Hace `fetch` + `merge` de la rama remota en la local |
| `git pull --rebase` | Hace `fetch` + `rebase` en lugar de merge |
| `git push` | Envia los commits locales al remoto |
| `git push -u origin <rama>` | Envia la rama y la vincula con la remota para futuros push/pull |
| `git push --force-with-lease` | Fuerza el push solo si el remoto no cambio desde el ultimo fetch |

## Deshacer cambios

| Comando | Que hace |
|---------|----------|
| `git restore <archivo>` | Descarta cambios en el working tree (vuelve al estado del staging) |
| `git restore --staged <archivo>` | Quita un archivo del staging sin perder los cambios |
| `git reset --soft HEAD~1` | Deshace el ultimo commit; deja los cambios en staging |
| `git reset --mixed HEAD~1` | Deshace el ultimo commit; deja los cambios en el working tree |
| `git reset --hard HEAD~1` | Deshace el ultimo commit y descarta todos los cambios (destructivo) |
| `git revert <hash>` | Crea un commit nuevo que revierte los cambios del commit indicado |
| `git stash` | Guarda cambios sin commitear en una pila temporal |
| `git stash pop` | Recupera el ultimo stash y lo elimina de la pila |
| `git stash list` | Lista todos los stashes guardados |
| `git stash drop` | Elimina el ultimo stash de la pila |
| `git clean -fd` | Elimina archivos y carpetas no rastreados (destructivo) |
| `git clean -n` | Muestra que archivos se eliminarian con `clean` (simulacion) |

## Inspeccion

| Comando | Que hace |
|---------|----------|
| `git log --oneline --graph --decorate --all` | Historial compacto con grafo, etiquetas y todas las ramas |
| `git log -p` | Historial mostrando el diff de cada commit |
| `git log --since="2 weeks ago"` | Commits de las ultimas dos semanas |
| `git log --author="nombre"` | Commits filtrados por autor |
| `git log <rama1>..<rama2>` | Commits en `<rama2>` que no estan en `<rama1>` |
| `git diff <rama1>...<rama2>` | Diferencias entre dos ramas desde su punto de divergencia |
| `git blame <archivo>` | Muestra quien modifico cada linea de un archivo y en que commit |
| `git bisect start` | Inicia una busqueda binaria para encontrar el commit que introdujo un bug |
| `git bisect good <hash>` | Marca un commit como bueno durante la biseccion |
| `git bisect bad <hash>` | Marca un commit como malo durante la biseccion |
| `git bisect reset` | Finaliza la busqueda binaria y vuelve a la rama original |
| `git reflog` | Muestra el historial de movimientos de HEAD (util para recuperar trabajo) |

## Historial avanzado

| Comando | Que hace |
|---------|----------|
| `git rebase -i HEAD~<n>` | Abre el rebase interactivo para los ultimos `<n>` commits (reordenar, editar, squash, etc.) |
| `git cherry-pick <hash>` | Aplica un commit especifico en la rama actual |
| `git cherry-pick --no-commit <hash>` | Aplica los cambios de un commit sin crear el commit automaticamente |
| `git tag <nombre>` | Crea una etiqueta ligera en el commit actual |
| `git tag -a <nombre> -m "mensaje"` | Crea una etiqueta anotada con mensaje |
| `git tag -l` | Lista todas las etiquetas |
| `git push origin <tag>` | Envia una etiqueta al remoto |
| `git push origin --tags` | Envia todas las etiquetas al remoto |
| `git tag -d <nombre>` | Elimina una etiqueta local |
