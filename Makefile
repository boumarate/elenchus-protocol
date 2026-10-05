.PHONY: setup build test fmt lint contracts-build contracts-test dev

setup:           ## Install JS dependencies and build the tokens
	pnpm install
	pnpm --filter @elenchus-protocol/tokens build

build:           ## Build JS packages and Soroban contracts
	pnpm build
	cd contracts && stellar contract build

test:            ## Run all tests
	cd contracts && cargo test
	pnpm typecheck

fmt:             ## Format Rust
	cd contracts && cargo fmt --all

lint:            ## Lint Rust
	cd contracts && cargo clippy --all-targets -- -D warnings

dev:             ## Start the web app
	pnpm dev:web
