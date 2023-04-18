vim.opt.autoread = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.nu = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.ai = true
vim.opt.si = true
vim.opt.foldenable = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = false
vim.g.mapleader = " "
vim.opt.completeopt = "menuone,noinsert,noselect"
-- Avoid showing extra messages when using completion
vim.opt.signcolumn= "yes"
vim.opt.updatetime = 50
vim.opt.background = "dark"

vim.keymap.set('n', 'g[', ':lprev<CR>', {})
vim.keymap.set('n', 'g]', ':lnext<CR>', {})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local has_lazy = vim.loop.fs_stat(lazypath)
if not has_lazy then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_method = 'latexrun'

require("lazy").setup({
    { 'ellisonleao/gruvbox.nvim' },

    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/nvim-cmp'},
    { 'hrsh7th/cmp-nvim-lsp'},
    { 'hrsh7th/cmp-vsnip'},
    { 'hrsh7th/cmp-path'},
    { 'hrsh7th/cmp-buffer'},

    { "nvim-telescope/telescope.nvim", dependencies = { { "nvim-lua/popup.nvim", lazy = false }, { "nvim-lua/plenary.nvim", lazy = false } } },
    -- { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    { "numToStr/Comment.nvim", config = function() require("Comment").setup() end, },

    { "ziglang/zig.vim" },

    { "lervag/vimtex" },
}, {})


local nvim_lsp = require'lspconfig'

local lsp_keymap_opts = {}
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, lsp_keymap_opts)
vim.keymap.set('n', 'gD', function() vim.lsp.buf.implementation() end, lsp_keymap_opts)
vim.keymap.set('n', '<c-k>', function() vim.lsp.buf.signature_help() end, lsp_keymap_opts)
vim.keymap.set('n', '1gD', function() vim.lsp.buf.type_definition() end, lsp_keymap_opts)
vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, lsp_keymap_opts)
vim.keymap.set('n', 'g0', function() vim.lsp.buf.document_symbol() end, lsp_keymap_opts)
vim.keymap.set('n', 'gW', function() vim.lsp.buf.workspace_symbol() end, lsp_keymap_opts)
vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, lsp_keymap_opts)
vim.keymap.set('n', 'ge', function() vim.diagnostic.setqflist() end, lsp_keymap_opts)
vim.keymap.set('n', 'ga', function() vim.lsp.buf.code_action() end, lsp_keymap_opts)
vim.keymap.set('n', 'gh', ':ClangdSwitchSourceHeader<CR>', lsp_keymap_opts)

nvim_lsp.zls.setup{}
nvim_lsp.clangd.setup{}

local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

-- require'nvim-treesitter.configs'.setup {
--   highlight = {
--     enable = false,
--     disable = true,
--   },
-- }

vim.cmd 'colorscheme gruvbox'

local telescope_builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>d', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>f', telescope_builtin.git_files, {})
vim.keymap.set('n', '<leader>g', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>r', telescope_builtin.resume, {})
