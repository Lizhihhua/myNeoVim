-- basics
vim.cmd[[syntax on]]
vim.cmd[[filetype plugin indent on]]

vim.opt.number = true             -- show line number
vim.opt.shiftround = true         
vim.opt.updatetime = 500          
vim.opt.cursorline = true         -- highlight current line
vim.opt.mouse = 'a'               -- allow you to use mouse
vim.opt.showmatch = true          -- show the match pair

-- encoding
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = 'ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1'


-- vim.opt.clipboard = vim.opt.clipboard ^ {'unnamed'}   -- clipboard
vim.opt.completeopt = 'menu,menuone,noselect'         -- complete menu

-- shutdown popupmenu and tabline
vim.opt.winaltkeys = 'no'
vim.opt.guifont='Consolas:h12:cANSI'

-- while j, k move, current line at last in [8, maxline - 8]
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.termguicolors = true

-- tabs = 4 * space
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- show the space = .
vim.opt.list = true
vim.opt.listchars = {space = '.'}

-- allow the indent
vim.opt.autoindent = true
vim.opt.smartindent = true

-- ignore the case while you search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = false    -- no highlight when return the search result
vim.opt.incsearch = true    -- show highlight when you input search target

vim.opt.cmdheight = 1       -- the height of command line = 1

-- auto load and write changes when the file is change
vim.opt.autoread = true
vim.opt.autowrite = true

-- no backup and no .swp file
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false


vim.opt.wildmenu = true         --
vim.opt.pumheight = 12          -- the complete menu maxHeight = 12

vim.wo.signcolumn = 'no'
-- disable some useless standard plugins to save startup time
-- these features have been better covered by plugins
vim.g.loaded_matchparen        = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_gzip              = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_shada_plugin      = 1
vim.g.loaded_spellfile_plugin  = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins    = 1

-- let python_path = the path of python.exe
vim.g.python_path = 'D:/ProgramFiles/Python/python.exe'

-- define the sign of error and warn for cmp
vim.fn.sign_define('DiagnosticSignError', {text = '>>', texthl = 'DiagnosticSignError', linehl = '', numhl = ''})
vim.fn.sign_define('DiagnosticSignWarn', {text = '~', texthl = 'DiagnosticSignWarn', linehl = '', numhl = ''})

