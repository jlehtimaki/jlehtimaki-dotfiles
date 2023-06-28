-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local keymap = vim.keymap.set
-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()
-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side
end

lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
	},
})

lspconfig.jsonls.setup({
	filetypes = { "json", "jsonc" },
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.yamlls.setup({
	filetypes = { "yaml", "yml" },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			validate = true,
		},
	},
})

lspconfig.ansiblels.setup({
	filetypes = { "yaml", "yml" },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		ansible = {
			ansible = {
				path = "/usr/bin/ansible",
			},
			ansibleLint = {
				path = "/usr/bin/ansible-lint",
			},
		},
	},
})

lspconfig.dockerls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "docker-langserver", "--stdio" },
	filetypes = { "Dockerfile", "dockerfile" },
	root_dir = lspconfig.util.root_pattern(".git", "Dockerfile"),
})

lspconfig.eslint.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "eslint_d", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_dir = lspconfig.util.root_pattern(".git", ".eslintrc.js", ".eslintrc.json", "package.json"),
})

-- lspconfig.helmls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	cmd = { "helm-language-server", "--stdio" },
-- 	filetypes = { "yaml", "yml" },
-- 	root_dir = lspconfig.util.root_pattern(".git", "Chart.yaml"),
-- })

lspconfig.terraformls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "terraform-ls", "serve" },
	filetypes = { "terraform", "tf" },
	root_dir = lspconfig.util.root_pattern(".terraform", ".git"),
	settings = {
		terraform = {
			useLanguageServer = true,
		},
	},
})

lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		-- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})
