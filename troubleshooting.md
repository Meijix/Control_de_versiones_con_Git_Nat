# Solución de problemas comunes en Git

Guía rápida para resolver los errores más frecuentes al trabajar con Git.

---

## 1. `You are in 'detached HEAD' state`

**Causa:** Hiciste checkout a un commit específico (`git checkout <hash>`) en lugar de a una rama. Los nuevos commits no pertenecerán a ninguna rama.

**Solución:**
```bash
# Crear una rama desde donde estás
git switch -c mi-rama-temporal

# O volver a una rama existente (los commits sin rama se perderán si no los guardas)
git switch main
```

---

## 2. `refusing to merge unrelated histories`

**Causa:** Intentas fusionar dos repositorios que no comparten un ancestro común (por ejemplo, un repo local nuevo con un remoto que ya tiene commits).

**Solución:**
```bash
git pull origin main --allow-unrelated-histories
```

Después resuelve cualquier conflicto que aparezca.

---

## 3. `Your branch and 'origin/main' have diverged`

**Causa:** Tanto tu rama local como la remota tienen commits que la otra no tiene. Suele pasar tras un `rebase` o si otra persona hizo push antes que tú.

**Solución:**
```bash
# Opción 1: rebase (historial lineal)
git pull --rebase origin main

# Opción 2: merge (conserva bifurcación)
git pull origin main
```

Si hiciste rebase de commits ya publicados y necesitas forzar:
```bash
git push --force-with-lease
```

---

## 4. `fatal: not a git repository (or any of the parent directories): .git`

**Causa:** Estás ejecutando un comando de Git fuera de un repositorio (no existe `.git/` en el directorio actual ni en sus padres).

**Solución:**
```bash
# Verifica dónde estás
pwd

# Navega al directorio correcto
cd /ruta/a/tu/proyecto

# O inicializa un repositorio nuevo
git init
```

---

## 5. `Permission denied (publickey)`

**Causa:** Tu clave SSH no está configurada o no es reconocida por el servidor (GitHub, GitLab, etc.).

**Solución:**
```bash
# 1. Verifica si tienes una clave SSH
ls ~/.ssh/id_ed25519.pub  # o id_rsa.pub

# 2. Si no existe, genera una nueva
ssh-keygen -t ed25519 -C "tu@correo.com"

# 3. Añade la clave al agente SSH
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# 4. Copia la clave pública y agrégala en tu cuenta de GitHub/GitLab
cat ~/.ssh/id_ed25519.pub

# 5. Verifica la conexión
ssh -T git@github.com
```

---

## 6. `error: failed to push some refs to 'origin'`

**Causa:** El remoto tiene commits que no tienes en tu copia local. Git no permite sobrescribirlos por defecto.

**Solución:**
```bash
# Trae los cambios del remoto y fusiona
git pull origin main

# Resuelve conflictos si los hay, luego:
git push origin main
```

**No uses `--force`** a menos que estés seguro de que no borrarás trabajo ajeno.

---

## 7. `CONFLICT (content): Merge conflict in <archivo>`

**Causa:** Dos ramas modificaron las mismas líneas del mismo archivo. Git no puede decidir cuál conservar.

**Solución:**
```bash
# 1. Abre el archivo y busca los marcadores
#    <<<<<<< HEAD
#    (tu cambio)
#    =======
#    (cambio entrante)
#    >>>>>>> rama

# 2. Edita dejando el código correcto y elimina los marcadores

# 3. Marca como resuelto
git add <archivo>

# 4. Finaliza
git commit          # si venías de un merge
git rebase --continue  # si venías de un rebase
```

Para cancelar la operación: `git merge --abort` o `git rebase --abort`.

---

## 8. `error: Your local changes to the following files would be overwritten`

**Causa:** Intentas cambiar de rama o hacer pull con cambios sin commitear que entran en conflicto.

**Solución:**
```bash
# Opción 1: guardar temporalmente los cambios
git stash
git switch otra-rama
# ... haz lo que necesites ...
git switch -     # vuelve a la rama anterior
git stash pop

# Opción 2: commitear los cambios antes de cambiar
git add -A
git commit -m "WIP: guardar progreso"
git switch otra-rama
```

---

## Consejo general

Ante cualquier error inesperado:

1. **Lee el mensaje completo** — Git suele sugerir la solución.
2. **`git status`** — Muestra el estado actual y qué hacer.
3. **`git reflog`** — Si perdiste commits, están ahí (ver [ejemplo de reflog](ejemplos/reflog/README.md)).
4. **No uses `--force`** sin entender las consecuencias.

## Referencias

- [Pro Git: Solución de problemas](https://git-scm.com/book/es/v2)
- [GitHub Docs: Troubleshooting](https://docs.github.com/es/get-started/getting-started-with-git)
