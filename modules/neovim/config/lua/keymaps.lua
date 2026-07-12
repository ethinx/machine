-- local keymap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

keymap("n", "<leader>sn", ":noh<cr>", default_opts)

keymap("i", "<C-a>", "<HOME>", default_opts)
keymap("i", "<C-e>", "<END>", default_opts)
keymap("i", "<C-f>", "<Right>", default_opts)
keymap("i", "<C-b>", "<Left>", default_opts)

keymap("n", "<tab>", "v>", default_opts)
keymap("v", "<tab>", "v>", default_opts)
keymap("n", "<s-tab>", "v<", default_opts)
keymap("v", "<s-tab>", "v<", default_opts)

-- Window control
keymap("", "<C-j>", "<C-w><C-j>", {})
keymap("", "<C-k>", "<C-w><C-k>", {})
keymap("", "<C-h>", "<C-w><C-h>", {})
keymap("", "<C-l>", "<C-w><C-l>", {})

-- 选中一段文字并全文搜索这段文字
-- via http://hotoo.googlecode.com/svn-history/r297/vimwiki/Vim.html#toc_1.4.3
keymap("v", "*", [[y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>]], default_opts)
keymap("v", "#", [[y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>]], default_opts)

-- https://zhuanlan.zhihu.com/p/20566792
keymap("v", "ss", [[y:%s`<C-R>"``g<left><left>]], default_opts)

keymap("", "<F2>", "<cmd>NvimTreeToggle<cr>", {})
keymap("", "<F9>", "<cmd>SymbolsOutline<cr>", {})

-- keymap('n', '<leader>w', ':w!<cr>', default_opts)

-- keymap('', '<leader>pi', ':PackerInstall', default_opts)
-- keymap('', '<leader>pu', ':PackerUpdate', default_opts)
-- keymap('', '<leader>pc', ':PackerClean', default_opts)

-- keymap('', '<leader>qa', ':qa!<cr>', default_opts)
-- keymap('', '<leader>wq', ':wq<cr>', default_opts)
keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", default_opts)
-- keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", default_opts)
-- keymap("n", "<leader>cr", "<cmd>Lspsaga rename ++project<CR>")
keymap("n", "<leader>cr", "<cmd>Lspsaga rename<CR>")
