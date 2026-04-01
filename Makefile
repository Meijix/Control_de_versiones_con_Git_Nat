# Makefile para ejecutar las demostraciones de Git
# Uso: make demos | make clean | make demo-<nombre> | make help

DEMO_DIRS := bisect blame cherry-pick diff-avanzado flujo-completo \
             hooks-pre-commit log-avanzado merge-conflictos \
             rebase-interactivo reflog reset revert stash tag worktree

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
