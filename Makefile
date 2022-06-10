mix          ?= mix
iex          ?= iex


help: Makefile
	@echo
	@echo " Choose a command run in octopus:"
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
	@$(mix) test


## build: Build code
.PHONY: build
build:
	@echo ">> ============= Build code ============= <<"
	@$(mix) compile --warnings-as-errors


## release: Release the code
.PHONY: release
release:
	@echo ">> ============= Release the code ============= <<"
	-rm -rf _build
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


## run: Run octopus
.PHONY: run
run:
	@echo ">> ============= Run octopus ============= <<"
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
