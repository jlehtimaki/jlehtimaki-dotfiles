local k = vim.keymap.set
-- directory listing
k("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
k("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
k("n", "<leader>fg", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
k("n", "<leader>fs", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
k("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
k("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- lazygit
k("n", "<leader>gg", "<cmd>LazyGit<cr>")

-- buffers
k("n", "<leader>bd", "<cmd>bd<cr>") -- delete buffer
k("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>") -- next buffer
k("n", "<leader>bp", "<cmd>BufferLineCyclePrev<cr>") -- previous buffer

-- Spectre
k("n", "<leader>sr", "<cmd>lua require('spectre').open()<cr>", { desc = "Search and replace" }) -- replace in files

-- Comment
k("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { desc = "Comment" }) -- comment
k(
	"v",
	"<leader>/",
	"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "Comment" }
) -- comment

-- leap
-- k("n", "<leader>s", "<cmd>lua require('leap').smart_send()<cr>", { desc = "Leap" }) -- leap

-- trouble
k("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document Diagnostics (Trouble)" })
k("n", "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace Diagnostics (Trouble)" })
k("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix List (Trouble)" })
k("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Location List (Trouble)" })

-- terminal
k("n","<leader>ct", "<cmd>exe v:count1 . \"ToggleTerm\"<CR>", {desc = "Terminal"})

-- Random
-- delete single character without copying into register
k("n", "x", '"_x')
-- increment/decrement numbers
k("n", "<leader>+", "<C-a>") -- increment
k("n", "<leader>-", "<C-x>") -- decrement
-- window management
k("n", "<leader>sv", "<C-w>v") -- split window vertically
k("n", "<leader>sh", "<C-w>s") -- split window horizontally
k("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
k("n", "<leader>sx", ":close<CR>") -- close current split window
-- vim-maximizer
k("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization
-- restart lsp server (not on youtube nvim video)
k("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

