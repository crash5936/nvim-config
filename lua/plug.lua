-- [[ plug.lua ]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
--    use 'williamboman/nvim-lsp-installer'
    use 'neovim/nvim-lspconfig'
    use 'simrat39/rust-tools.nvim'

    -- useful completion sources
    use {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/nvim-cmp",
        "hrsh7th/vim-vsnip",
    }

    use 'nvim-treesitter/nvim-treesitter'

    use 'puremourning/vimspector'

    use 'voldikss/vim-floaterm'

    use 'nvim-telescope/telescope.nvim'
    use 'phaazon/hop.nvim'

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons'
        },
    }

    use 'Mofiqul/dracula.nvim'

end)
