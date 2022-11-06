--[[ init.lua ]]

-- LEADER
vim.g.mapleader = ","
vim.g.localleader = "\\"

-- IMPORTS
require('vars')		-- Variables
require('opts')		-- Options
require('keys')	    -- Keymaps
require('plug')	    -- Plugin

-- PLUGINS
require('mason').setup({
    PATH = "prepend"
})
require('lspconfig').rust_analyzer.setup({})

local rt = require('rust-tools')

-- LSP Diagnostics Options Setup
local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = ''
    })
end

sign({name = 'DiagnosticsSignError', text = "❗"})
sign({name = 'DiagnosticsSignWarn', text = "⚠️"})
sign({name = 'DiagnosticsSignHint', text = "💡"})
sign({name = 'DiagnosticsSignInfo', text = "ℹ️"})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underlione = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

-- Treesitter Plugin Setup
require('nvim-treesitter.configs').setup({
    ensure_installed = { "lua", "rust", "toml" },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    ident = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
})

-- Treesitter folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- Completion Plugin Setup
local cmp = require('cmp')
cmp.setup({
    -- Enable LSP snippets
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
        ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
    },
    -- Installed sources
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp', keyword_length = 3 },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua', keyword_length = 2 },
        { name = 'buffer', keyword_length = 2 },
        { name = 'vsnip', keyword_length = 2},
        { name = 'calc' },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = function(entry, item)
            local menu_icon = {
                nvim_lsp = 'λ',
                vsnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
            }
            item.menu = menu_icon[entry.source.name]
            return item
        end,
    },
})

-- Hop Setup
require('hop').setup()

-- nvimtree Setup
require("nvim-tree").setup()

-- nvim web devicons
require('nvim-web-devicons').setup({
    default = true
})
