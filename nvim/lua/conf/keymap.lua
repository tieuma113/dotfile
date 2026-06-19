local map = vim.keymap.set
-- vim.keymap.set defaults to noremap; we only need silent + per-map desc.
local opts = { silent = true }
local function d(desc)
  return { silent = true, desc = desc }
end

-- Remap space as leader key
map("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
map("n", "<C-h>", "<C-w>h", d("Window left"))
map("n", "<C-j>", "<C-w>j", d("Window down"))
map("n", "<C-k>", "<C-w>k", d("Window up"))
map("n", "<C-l>", "<C-w>l", d("Window right"))

-- Keep cursor centered while scrolling
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Resize with arrows
map("n", "<C-Up>", ":resize +1<CR>", opts)
map("n", "<C-Down>", ":resize -1<CR>", opts)
map("n", "<C-Left>", ":vertical resize -1<CR>", opts)
map("n", "<C-Right>", ":vertical resize +1<CR>", opts)

-- Navigate buffers
map("n", "<S-l>", ":bnext<CR>", d("Next buffer"))
map("n", "<S-h>", ":bprevious<CR>", d("Previous buffer"))

-- Disable Ex mode
map("n", "Q", "<nop>", opts)

-- Visual --
-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m .-2<CR>==", opts)
-- Paste over selection without yanking the replaced text
map("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv=gv", opts)
map("x", "K", ":move '<-2<CR>gv=gv", opts)
map("x", "<A-j>", ":move '>+1<CR>gv=gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv=gv", opts)
map("x", "p", '"_dP', opts)

-- Terminal --
-- Better terminal navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
map("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
map("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
map("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)
