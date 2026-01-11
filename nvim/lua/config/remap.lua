-- Seu arquivo de keymaps padrão (ex: lua/config/keymaps.lua ou init.lua)
local map = vim.keymap.set

vim.g.mapleader = " "

-- Melhor movimento up/down (respeita linhas wrapadas)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Navegação entre windows com Ctrl + hjkl
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Redimensionar windows com Ctrl + setas
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Mover linhas
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==gv", { desc = "Move Line Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==gv", { desc = "Move Line Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Line Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Line Up" })
map("v", "<A-j>", ":move '>+1<cr>gv=gv", { desc = "Move Selection Down" })
map("v", "<A-k>", ":move '<-2<cr>gv=gv", { desc = "Move Selection Up" })

-- Navegação entre buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Alternate Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Alternate Buffer" })

-- Deletar buffer (usando :bd padrão, já que Snacks.bufdelete não existe aqui)
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete Buffer" })
map("n", "<leader>bD", "<cmd>bd!<cr>", { desc = "Delete Buffer (Force)" })

-- Clear highlight de busca ao pressionar Esc
map("n", "<esc>", "<cmd>noh<cr><esc>", { desc = "Clear Search Highlight" })

-- Redesenhar tela e limpar highlight/diff
map("n", "<leader>ur", "<cmd>nohlsearch<bar>diffupdate<bar>normal! <C-L><cr>", { desc = "Redraw / Clear hlsearch / Diff Update" })

-- Busca mais inteligente (n/N respeita direção)
map("n", "n", "'Nn'[v:searchforward] .. 'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward] .. 'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Undo break points em inserção
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")

-- Salvar arquivo
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Keywordprg (K padrão)
map("n", "<leader>K", "K", { desc = "Keywordprg" })

-- Melhor indentação visual
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Comentário extra (adicionar linha comentada abaixo/acima)
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- Novo arquivo
map("n", "<leader>a", "<cmd>enew<cr>", { desc = "New File" })

-- Location list e Quickfix
map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Toggle Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Toggle Quickfix List" })
map("n", "[q", "<cmd>cprev<cr>", { desc = "Previous Quickfix" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next Quickfix" })

-- Diagnósticos (assumindo vim.diagnostic padrão)
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", function() vim.diagnostic.jump({ count = vim.v.count1 }) end, { desc = "Next Diagnostic" })
map("n", "[d", function() vim.diagnostic.jump({ count = -vim.v.count1 }) end, { desc = "Prev Diagnostic" })
map("n", "]e", function() vim.diagnostic.jump({ count = vim.v.count1, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Next Error" })
map("n", "[e", function() vim.diagnostic.jump({ count = -vim.v.count1, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Prev Error" })
map("n", "]w", function() vim.diagnostic.jump({ count = vim.v.count1, severity = vim.diagnostic.severity.WARN }) end, { desc = "Next Warning" })
map("n", "[w", function() vim.diagnostic.jump({ count = -vim.v.count1, severity = vim.diagnostic.severity.WARN }) end, { desc = "Prev Warning" })

-- Split windows
map("n", "<leader>-", "<C-w>s", { desc = "Split Window Horizontally" })
map("n", "<leader>|", "<C-w>v", { desc = "Split Window Vertically" })
map("n", "<leader>wd", "<C-w>c", { desc = "Close Window" })

-- Tabs
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

map("n", "<leader>pv", "<cmd>Oil<cr>", { desc = "Open Oil (file tree)" })  -- assumindo que você usa Oil
-- map("n", "a", ":Ex<cr>", { desc = "Open Netrw" })  -- evite sobrescrever 'a' (append), comente se quiser
--
--terminal
--vim.api.nvim_set_keymap('n', '<leader>t', ':split | terminal<CR>', { desc = "open terminal" })
---vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {desc = "close terminal"})



