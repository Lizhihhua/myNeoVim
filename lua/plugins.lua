-- packer.nvim
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
    use 'wbthomason/packer.nvim'    -- 插件管理器

    -- 主题
    -- use 'tomasr/molokai'            -- molokai主题
    use 'sainnhe/sonokai'

    use 'Yggdroot/indentLine'              -- 分割线

    -- 一键编译运行, F12编译，F5运行
    use 'skywind3000/asynctasks.vim'        -- 自定义一键编译运行, 模仿vscode
    use 'skywind3000/asyncrun.vim'

    use "terrortylor/nvim-comment"          -- 注释

    -- 启动优化
    use "lewis6991/impatient.nvim"
    use 'nathom/filetype.nvim'

    -- bufferline
    use {
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons'
    }
    use 'moll/vim-bbye' -- for more sensible delete buffer cmd

    -- file tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = 'kyazdani42/nvim-web-devicons'
    } 

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' } 
    }

    -- tagbar
    use 'simrat39/symbols-outline.nvim'

    -- floating terminal
    use 'voldikss/vim-floaterm'               

    -- highlight for cpp
    use 'octol/vim-cpp-enhanced-highlight'    -- C++语法高亮

    -- difference color for pairs
    use 'luochen1990/rainbow'                 

    -- auto-pairs
    use 'jiangmiao/auto-pairs'              

    -- 代码调试基础插件
    use {
        "mfussenegger/nvim-dap",
        config = function()
            require("dap.nvim-dap")
        end
    }
    -- 为代码调试提供内联文本
    use {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("dap.nvim-dap-virtual-text")
        end
    }
    -- 为代码调试提供 UI 界面
    use {
        "rcarriga/nvim-dap-ui",
        config = function()
            require("dap.nvim-dap-ui")
        end
    }

    -- cmp自动补全
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use {
        'hrsh7th/nvim-cmp',
        commit = "dbc72290295cfc63075dab9ea635260d2b72f2e5",
    } 
    -- vsnip代码片段补全
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- lspkind, 像vscode一样的补全菜单窗口
    use 'onsails/lspkind.nvim'

    -- highlight undercursor word
    use "RRethy/vim-illuminate"       
end)


