DIR         = '/nonesuch/directory/really'

THE_COMMAND	= 'pwd'

default: show

checkout:
	@git submodule update

show:
	@echo All submodules:
	@$(MAKE) for-all-submodules THE_TARGET=show-one

diff:
	@git diff --submodule

show-one:
	@du -s "$(DIR)" | sed -e 's/^/	/'

du:
	du -I .git | sort -n

prune:
	@$(MAKE) for-all-submodules THE_TARGET=prune-one

prune-one:
	@if [ -d "$(DIR)" ]; then \
		echo "DIR is [$(DIR)]"; \
		for s in `ls -A $(DIR)`; do \
			rm -fr "$(DIR)/$$s"; \
		done; \
	else \
		echo "bad DIR [$(DIR)]"; \
		exit 1; \
	fi

for-all-submodules:
	@for s in `find * -name .git -exec dirname {} \;`; do $(MAKE) $(THE_TARGET) DIR="$$s"; done

submodule-foreach:
	@git submodule foreach $(THE_COMMAND)

