--Remap space as leader key
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false


-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- :map <C-w>t to new tab
vim.keymap.set('n', '<C-w>t', ':tabnew<CR>', { noremap = true, silent = true })

-- :map <C-w> in terminal mode to switch to normal
vim.keymap.set('t', '<C-w>', '<C-\\><C-n>', { noremap = true})

-- set both shiftwidth and tabstop for a file
vim.api.nvim_create_user_command('Swts',
function(opts)
	vim.api.nvim_set_option('shiftwidth', tonumber(opts.args))
	vim.api.nvim_set_option('tabstop', tonumber(opts.args))
	vim.api.nvim_buf_set_option(0, 'shiftwidth', tonumber(opts.args))
	vim.api.nvim_buf_set_option(0, 'tabstop', tonumber(opts.args))
end,
{nargs=1})

