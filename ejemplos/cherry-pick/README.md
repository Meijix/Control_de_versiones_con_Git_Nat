# Cherry-pick (`git cherry-pick`)

## Propósito

Aplicar **uno o varios commits concretos** de otra rama sobre la rama actual, **sin** fusionar toda la rama. Útil para llevar un arreglo puntual de `develop` a `release` o para extraer trabajo aislado.

## Para quién es esta guía

Personas que ya distinguen **rama** y **commit**, y necesitan trasladar cambios **granulares** sin `merge` completo.

## Prerrequisitos

- Saber leer `git log --oneline` y copiar un hash de commit (`git rev-parse` / primeros caracteres del hash).
- Entender que cherry-pick **crea commits nuevos** con distinto hash si el parche se aplica sobre otra base (mismo cambio, distinto SHA).

## Objetivos de aprendizaje

1. Elegir el commit correcto (sobre todo si hay varios en la rama de origen).
2. Ejecutar `git cherry-pick <hash>` y resolver conflictos si el contexto difiere.
3. Usar `cherry-pick` con varios hashes o rangos (`A^..B`) cuando el flujo lo requiera.

## Escenario

En `main` solo vive un README estable. En la rama `feature/login` hay dos commits: primero se añade `login.txt` básico; después otro commit añade la línea de sesión. Quieres llevar **solo** el primer commit a `main` (por ejemplo, desplegar la parte mínima del login sin el segundo cambio).

## Cómo ejecutar la demostración

```bash
bash demo-setup.sh
```

Se crea `_demo-cherry-pick/` con el historial descrito y se ejecuta un `cherry-pick` del primer commit de la feature sobre `main`.

## Pasos manuales (para repetir o enseñar)

1. `git checkout main`
2. `git cherry-pick <hash>` — el hash del commit que quieres replicar.
3. Si hay conflicto: edita archivos, `git add`, `git cherry-pick --continue`.
4. Para cancelar: `git cherry-pick --abort`.

## Notas que suelen confundir

| Concepto | Aclaración |
|----------|------------|
| Cherry-pick vs merge | Merge trae **toda** la rama hasta el punto de unión; cherry-pick solo **parches** de commits elegidos. |
| Mismo cambio, otro hash | El nuevo commit en `main` no es idéntico al original; no mezcles mentalmente ambos al hacer `revert`. |
| Orden de varios picks | Aplica en orden cronológico salvo que sepas lo que haces; a veces conviene `rebase -i` en la rama fuente primero. |

## Cómo documentar para otros desarrolladores

Además de la plantilla general (propósito, requisitos, pasos, verificación, fallos):

- **Indica siempre de qué rama sale el commit** y hacia cuál va, con un diagrama ASCII simple si hay varias ramas.
- **Documenta el criterio de elegibilidad**: “solo hotfixes etiquetados”, “commits con mensaje `fix:`”, etc.
- **Incluye el comando de rollback**: `git revert <hash_del_cherry_pick>` en `main`, no el hash del commit original en la otra rama.

### Ejemplo de sección “Verificación”

```text
git log -1 --oneline    # debe mostrar el mensaje del commit cherry-pickeado
ls login.txt            # debe existir con el contenido esperado
```

## Referencias

- [git cherry-pick](https://git-scm.com/docs/git-cherry-pick)
- Pro Git: [Reescritura del historial / cherry-pick](https://git-scm.com/book/es/v2/Herramientas-de-Git-Herramientas-de-Reparaci%C3%B3n)
