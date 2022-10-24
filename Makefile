mix          ?= mix
iex          ?= iex


help: Makefile
	@echo
	@echo " Choose a command run in Lynx:"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo


## fmt: Format code.
.PHONY: fmt
fmt:
	@echo ">> ============= Format code ============= <<"
	@$(mix) format mix.exs "lib/**/*.{ex,exs}" "test/**/*.{ex,exs}"


## fmt_check: Check code format.
.PHONY: fmt_check
fmt_check:
	@echo ">> ============= Check code format ============= <<"
	@$(mix) format mix.exs "lib/**/*.{ex,exs}" "test/**/*.{ex,exs}" --check-formatted


## deps: Fetch dependencies
.PHONY: deps
deps:
	@echo ">> ============= Fetch dependencies ============= <<"
	@$(mix) deps.get


## test: Test code
.PHONY: test
test:
	@echo ">> ============= Test code ============= <<"
	@$(mix) test --trace


## build: Build code
.PHONY: build
build:
	@echo ">> ============= Build code ============= <<"
	@$(mix) compile --warnings-as-errors --all-warnings


## release: Release the code
.PHONY: release
release:
	@echo ">> ============= Release the code ============= <<"
	-rm -rf _build
	# mix phx.digest
	MIX_ENV=prod mix release


## i: Run interactive shell
.PHONY: i
i:
	@echo ">> ============= Interactive shell ============= <<"
	@$(iex) -S mix phx.server


## migrate: Create database
.PHONY: migrate
migrate:
	@echo ">> ============= Create database ============= <<"
	@$(mix) ecto.setup


## run: Run lynx
.PHONY: run
run:
	@echo ">> ============= Run lynx ============= <<"
	@$(mix) phx.server


## ecto: Run ecto
.PHONY: ecto
ecto:
	@echo ">> ============= Run ecto ============= <<"
	@$(mix) ecto


## v: Get version
.PHONY: v
v:
	@echo ">> ============= Get application version ============= <<"
	@$(mix) version


## ci: Run ci
.PHONY: ci
ci: test
