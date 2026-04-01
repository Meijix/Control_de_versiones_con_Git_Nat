# Makefile para ejecutar las demostraciones de Git
# Uso: make demos | make clean | make demo-<nombre> | make help

DEMO_DIRS := 01-stash 02-diff-avanzado 03-log-avanzado 04-merge-conflictos \
             05-blame 06-reset 07-revert 08-reflog 09-cherry-pick \
             10-rebase-interactivo 11-bisect 12-tag 13-worktree \
             14-hooks-pre-commit 17-flujo-completo

.PHONY: demos all-demos clean help $(addprefix demo-,$(DEMO_DIRS))

help:
	@echo "Targets disponibles:"
	@echo "  make demos          - ejecuta todas las demostraciones"
	@echo "  make clean          - elimina los directorios _demo-*/"
	@echo "  make demo-<nombre>  - ejecuta una demostración individual"
	@echo ""
	@echo "Demostraciones disponibles:"
	@$(foreach d,$(DEMO_DIRS),echo "  make demo-$(d)";)

demos: all-demos

all-demos: $(addprefix demo-,$(DEMO_DIRS))

define DEMO_RULE
demo-$(1):
	@echo "=== Ejecutando demostración: $(1) ==="
	@bash ejemplos/$(1)/demo-setup.sh
	@echo ""
endef

$(foreach d,$(DEMO_DIRS),$(eval $(call DEMO_RULE,$(d))))

clean:
	@echo "Eliminando directorios _demo-*/..."
	@find ejemplos -type d -name '_demo-*' -exec rm -rf {} + 2>/dev/null || true
	@echo "Limpieza completada."
