# Etiquetas (`git tag`)

## Proposito

Marcar puntos especificos del historial (releases, versiones) con **etiquetas ligeras** y **anotadas**. Las etiquetas permiten identificar rapidamente versiones estables, hitos de produccion y puntos de referencia en el ciclo de vida del proyecto.

## Para quien es esta guia

Desarrolladores que gestionan **releases** o **versiones** de un proyecto y necesitan marcar commits concretos para facilitar el seguimiento y la navegacion del historial.

## Prerrequisitos

- Saber crear commits (`git commit`) y leer el historial (`git log --oneline`).
- Entender que cada commit tiene un hash unico que lo identifica.

> **Windows**: ejecuta los scripts en **Git Bash** (incluido con [Git for Windows](https://gitforwindows.org/)).

## Objetivos de aprendizaje

1. Distinguir entre **etiquetas ligeras** (lightweight) y **etiquetas anotadas** (annotated): cuando usar cada una y que informacion almacenan.
2. Listar e inspeccionar etiquetas con `git tag -l` y `git show <tag>`.
3. Eliminar etiquetas locales (`git tag -d`) y gestionar etiquetas en remotos (`git push --tags`, `git push origin <tag>`).

## Escenario

Se simulan cuatro commits que representan la evolucion de un proyecto:

1. **Commit 1** -- Inicializacion del proyecto (`init`).
2. **Commit 2** -- Modulo de usuarios (`users`).
3. **Commit 3** -- Modulo de pedidos (`orders`).
4. **Commit 4** -- Modulo de pagos (`payments`).

Sobre este historial:

- Se crea una **etiqueta ligera** `v0.1.0` en el commit 2 (primera version funcional minima).
- Se crea una **etiqueta anotada** `v1.0.0` en HEAD (release estable).
- Se listan, inspeccionan y finalmente se elimina `v0.1.0` para demostrar el ciclo completo.

## Como ejecutar la demostracion

```bash
bash demo-setup.sh
```

Se crea `_demo-tag/` con el historial descrito y se ejecutan las operaciones de etiquetado paso a paso.

## Pasos manuales (para repetir o ensenar)

1. Crear varios commits en un repositorio de prueba.
2. Crear una etiqueta ligera sobre un commit anterior:
   ```bash
   git tag v0.1.0 <hash_del_commit>
   ```
3. Crear una etiqueta anotada sobre HEAD:
   ```bash
   git tag -a v1.0.0 -m "Release estable 1.0.0"
   ```
4. Listar todas las etiquetas:
   ```bash
   git tag -l
   ```
5. Inspeccionar la etiqueta anotada (muestra autor, fecha, mensaje y commit):
   ```bash
   git show v1.0.0
   ```
6. Inspeccionar la etiqueta ligera (muestra solo el commit):
   ```bash
   git show v0.1.0
   ```
7. Eliminar una etiqueta local:
   ```bash
   git tag -d v0.1.0
   ```
8. Verificar que solo queda `v1.0.0`:
   ```bash
   git tag -l
   ```

## Notas que suelen confundir

| Concepto | Aclaracion |
|----------|------------|
| Ligera vs anotada | La ligera es solo un puntero a un commit (como un alias). La anotada crea un **objeto tag** con autor, fecha y mensaje; es la recomendada para releases. |
| `git push --tags` vs `git push origin <tag>` | `--tags` envia **todas** las etiquetas locales al remoto. `push origin <tag>` envia solo una, mas seguro en equipos grandes para evitar publicar etiquetas de prueba. |
| Las etiquetas son inmutables | No puedes mover una etiqueta a otro commit sin eliminarla primero (`git tag -d`) y recrearla. Esto es intencionado: garantiza que `v1.0.0` siempre apunta al mismo commit. |
| Convencion SemVer | Muchos proyectos usan [Semantic Versioning](https://semver.org/): `vMAJOR.MINOR.PATCH`. No es obligatorio, pero facilita la comunicacion entre equipos y herramientas de CI/CD. |

## Como documentar para otros desarrolladores

Ademas de la plantilla general (proposito, requisitos, pasos, verificacion, fallos):

- **Define la convencion de nombres**: `v1.0.0`, `release-2024.03`, etc. Documenta el patron para que todo el equipo lo siga.
- **Indica quien puede crear tags de release**: en equipos grandes, solo el lead o CI/CD deberian crear etiquetas anotadas en `main`.
- **Documenta el flujo de push**: si se usa `git push origin <tag>` individualmente o `git push --tags` tras validar.
- **Incluye rollback**: para eliminar una etiqueta ya publicada, se necesita `git push origin --delete <tag>` ademas de `git tag -d <tag>` local.

### Ejemplo de seccion "Verificacion"

```text
git tag -l                  # debe mostrar v1.0.0
git show v1.0.0             # debe mostrar autor, fecha, mensaje y el commit asociado
git log --oneline --decorate # los commits etiquetados muestran (tag: vX.Y.Z)
```

## Referencias

- [git tag](https://git-scm.com/docs/git-tag)
- Pro Git: [Etiquetado](https://git-scm.com/book/es/v2/Fundamentos-de-Git-Etiquetado)
- [Semantic Versioning](https://semver.org/)
