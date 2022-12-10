-- Installs and configs plugins using packer

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
  return string.format('require("config/%s")', name)
end

local fn = vim.fn

local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer...")
  vim.api.nvim_command("packadd packer.nvim")
end

local packer = require("packer")

packer.init({
  enable = true, -- enable profiling via :PackerCompile profile=true
  threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  max_jobs = 20, -- Limit the number of simultaneous jobs. nil means no limit. Set to 20 in order to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
  -- Have packer use a popup window
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

packer.startup(function(use)
 	-- Package manager
	use({ 'wbthomason/packer.nvim' })

	-- Git commands in nvim
	use({ 'tpope/vim-fugitive' })
	-- Fugitive-companion to interact with github
	-- use 'tpope/vim-rhubarb' 

	-- "gc" to comment visual regions/lines
	use({
		'numToStr/Comment.nvim',
		config = function()
			require("Comment").setup()
		end,
	})

	-- use 'ludovicchabant/vim-gutentags' -- Automatic tags management

	-- Fancier statusline
	use({
		'nvim-lualine/lualine.nvim',
		config = get_config("lualine")
	})

	-- UI to select things (files, grep results, open buffers...)
	use({
		'nvim-telescope/telescope.nvim',
		requires = {
			'nvim-lua/popup.nvim',
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-media-files.nvim'
		},
		config = get_config("telescope")
	})
	use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })

	-- -- Set colorscheme
	-- use({ 'mjlbach/onedark.nvim', -- Theme inspired by Atom
	-- config = function ()
	-- 	vim.o.termguicolors = true
	-- 	vim.cmd [[colorscheme onedark]]
	-- end,
	-- })


	-- Add indentation guides even on blank lines
	use('lukas-reineke/indent-blankline.nvim')

	-- Add git related info in the signs columns and popups
	use({
		'lewis6991/gitsigns.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = get_config("gitsigns")
	})

	-- Highlight, edit, and navigate code using a fast incremental parsing library
	use({'nvim-treesitter/nvim-treesitter',
		config = get_config("treesitter")
	})
	-- Additional textobjects for treesitter
	use({'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter'})

	-- Collection of configurations for built-in LSP client
	use({'neovim/nvim-lspconfig',
		config = get_config("lspconfig")
	})

	-- Autocompletion plugin
	use({
		'hrsh7th/nvim-cmp',
		requires = 'hrsh7th/cmp-nvim-lsp',
	})
	use({
		"L3MON4D3/LuaSnip",
		requires = "saadparwaiz1/cmp_luasnip",
		config = get_config("cmp"), -- contains config for both cmp and luasnip
	})

	-- file explorer
	use({
		'ms-jpq/chadtree',
		config = get_config("chadtree")
	})

	-- focus mode
	use({'junegunn/goyo.vim'})

	-- zettelkasten plugin
	use({
		'renerocksai/telekasten.nvim',
		requires = {'renerocksai/calendar-vim'},
		config = get_config("telekasten");
	})
end)
