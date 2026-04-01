# Mapa de decisión de comandos Git

¿No sabes qué comando usar? Sigue la ruta según lo que necesitas hacer.

---

## Quiero deshacer algo

```
¿Qué quiero deshacer?
│
├── Cambios en un archivo que NO he añadido al staging
│   └── git restore <archivo>
│
├── Un archivo que ya añadí al staging (git add)
│   └── git restore --staged <archivo>
│
├── El último commit (aún NO hice push)
│   ├── Quiero conservar los cambios en staging
│   │   └── git reset --soft HEAD~1
│   ├── Quiero conservar los cambios sin staging
│   │   └── git reset HEAD~1
│   └── Quiero descartar todo (DESTRUCTIVO)
│       └── git reset --hard HEAD~1
│
├── Un commit que YA está en el remoto (push hecho)
│   └── git revert <hash>          (crea nuevo commit, seguro)
│
└── Perdí commits tras un reset
    └── git reflog                  (busca el hash perdido)
        └── git reset --hard <hash>
```

---

## Quiero ver diferencias

```
¿Entre qué quiero comparar?
│
├── Working tree vs staging
│   └── git diff
│
├── Staging vs último commit
│   └── git diff --staged
│
├── Dos ramas
│   ├── Diferencia completa (tip a tip)
│   │   └── git diff rama1..rama2
│   └── Desde el punto de divergencia
│       └── git diff rama1...rama2
│
├── Dos commits específicos
│   └── git diff <hash1>..<hash2>
│
├── Resumen estadístico
│   └── git diff --stat
│
├── A nivel de palabra
│   └── git diff --word-diff
│
└── Quién cambió cada línea de un archivo
    └── git blame <archivo>
```

---

## Quiero trabajar con ramas

```
¿Qué necesito hacer?
│
├── Ver mis ramas
│   ├── Solo locales → git branch
│   └── Todas (local + remoto) → git branch -a
│
├── Crear una rama
│   ├── Sin cambiarme → git branch <nombre>
│   └── Crear y cambiarme → git switch -c <nombre>
│
├── Cambiar de rama
│   └── git switch <nombre>
│
├── Fusionar una rama en la actual
│   ├── Merge (conserva bifurcación) → git merge <rama>
│   └── Rebase (historial lineal) → git rebase <rama>
│
├── Eliminar una rama
│   ├── Seguro (ya fusionada) → git branch -d <nombre>
│   └── Forzado → git branch -D <nombre>
│
└── Tengo cambios sin commitear y quiero cambiar de rama
    └── git stash → git switch <rama> → git stash pop
```

---

## Quiero sincronizar con el remoto

```
¿Qué necesito hacer?
│
├── Ver qué hay de nuevo sin fusionar
│   └── git fetch
│       └── git log main..origin/main    (ver commits nuevos)
│
├── Traer cambios y fusionar
│   ├── Con merge → git pull
│   └── Con rebase → git pull --rebase
│
├── Enviar mis commits
│   └── git push
│       └── Primera vez en esta rama → git push -u origin <rama>
│
└── El push falla ("failed to push some refs")
    └── git pull → resolver conflictos → git push
```

---

## Quiero inspeccionar el historial

```
¿Qué busco?
│
├── Ver commits recientes
│   └── git log --oneline --graph --all
│
├── Buscar un commit por mensaje
│   └── git log --grep="texto"
│
├── Buscar quién cambió un archivo
│   └── git blame <archivo>
│
├── Buscar en qué commit se introdujo un cambio
│   ├── Por contenido → git log -S "texto"
│   └── Por búsqueda binaria → git bisect
│
└── Ver movimientos recientes de HEAD
    └── git reflog
```

---

## Quiero marcar una versión

```
¿Qué tipo de marca?
│
├── Etiqueta ligera (solo un nombre)
│   └── git tag v1.0.0
│
├── Etiqueta anotada (con autor, fecha y mensaje)
│   └── git tag -a v1.0.0 -m "Release 1.0.0"
│
└── Enviar etiqueta al remoto
    ├── Una sola → git push origin v1.0.0
    └── Todas → git push origin --tags
```

---

## Referencias

- [Hoja de referencia rápida](cheat-sheet.md)
- [Guía de solución de problemas](troubleshooting.md)
- [Glosario de términos](glosario.md)
