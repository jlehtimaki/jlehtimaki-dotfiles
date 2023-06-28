local nl = require("null-ls")

require("mason-null-ls").setup({
	ensure_installed = {
		"ansible-language-server",
		"ansible-lint",
		"commitlint",
		"dockerfile-language-server",
		"codespell",
		"gitlint",
		"golangci-lint-langserver",
		"golangci-lint",
		"gopls",
		"golines",
		"goimports",
		"grammarly-languageserver",
		"hadolint",
		"helm",
		"html-lsp",
		"jsonlint",
		"json-lsp",
		"jq-lsp",
		"lua-language-server",
		"markdownlint",
		"misspell",
		"pylint",
		"pyright",
		"rust_analyzer",
		"rustfmt",
		"shellcheck",
		"stylelua",
		"stylelint",
		"textlint",
		"tflint",
		"tfsec",
		"terraform-ls",
		"terraform-fmt",
		"vim-language-server",
		"yaml-language-server",
		"yamllint",
	},
	automatic_installation = false,
	handlers = {},
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup({
	sources = {
		nl.builtins.code_actions.shellcheck,
		nl.builtins.completion.luasnip,
		nl.builtins.formatting.codespell,
		nl.builtins.formatting.gofumpt,
		nl.builtins.formatting.goimports_reviser,
		nl.builtins.formatting.golines,
		nl.builtins.formatting.jq,
		nl.builtins.formatting.lua_format,
		nl.builtins.formatting.markdownlint,
		nl.builtins.formatting.prettier,
		nl.builtins.formatting.rustfmt,
		-- nl.builtins.formatting.yq,
		nl.builtins.formatting.terraform_fmt,
		nl.builtins.diagnostics.ansiblelint,
		nl.builtins.diagnostics.codespell,
		nl.builtins.diagnostics.golangci_lint,
		nl.builtins.diagnostics.gospel,
		nl.builtins.diagnostics.hadolint,
		nl.builtins.diagnostics.markdownlint,
		nl.builtins.diagnostics.yamllint,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
