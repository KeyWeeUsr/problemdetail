.PHONY: all
all:
	v -shared .

.PHONY: local-install
local-install:
	ln -fs $$PWD ~/.vmodules/problemdetail

.PHONY: local-uninstall
local-uninstall:
	test -L "$(HOME)/.vmodules/problemdetail" \
	&& rm "$(HOME)/.vmodules/problemdetail"

examples/examples:
	@test -d ~/.vmodules/problemdetail -o -L ~/.vmodules/problemdetail \
	|| ( \
		echo "Install package either from remote or by 'make local-install'" \
		&& exit 1 \
	)
	v examples

.PHONY: run-examples
run-examples: examples/examples
	examples/examples
