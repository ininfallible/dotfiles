--Set highlight on search
vim.o.hlsearch = true

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

-- tabs are 4 spaces wide
vim.o.tabstop = 4
vim.o.shiftwidth = 4

--Column on line 80
vim.opt.colorcolumn="81"
vim.cmd([[hi ColorColumn ctermbg=DarkGray]])
vim.api.nvim_set_hl(0, 'ColorColumn' , {ctermbg = "DarkGray"})

-- vim.o.cursorline = true
-- vim.cmd([[hi CursorLine term=bold cterm=none ctermbg=DarkGray]])

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme
-- vim.o.termguicolors = true
-- vim.cmd [[colorscheme onedark]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- vim.o.termguicolors = true
vim.api.nvim_set_hl(0, 'NormalFloat' , {fg = "LightGrey"})

-- TELEKASTEN HIGHLIGHTS
vim.api.nvim_set_hl(0, 'tkLink' , {ctermfg = "Blue", bold = true, underline = true})
vim.api.nvim_set_hl(0, 'tkBrackets' , {ctermfg = "Gray"})
vim.api.nvim_set_hl(0, 'tkHighlight' , {ctermbg = "Yellow", ctermfg = "Black", bold = true})
vim.api.nvim_set_hl(0, 'tkTag' , {ctermfg = "LightGreen", underline = true})
vim.api.nvim_set_hl(0, 'CalNavi', {link = 'CalRuler'})
