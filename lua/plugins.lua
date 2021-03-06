vim.cmd [[packadd packer.nvim]]

vim.g.kommentary_create_default_mappings = false

return require('packer').startup(function()
	use {'wbthomason/packer.nvim', opt = true}
	use {
		'datwaft/bubbly.nvim',
		config = function()
			vim.g.bubbly_palette = {
      				background = "StatusLine background",
      				foreground = "StatusLine foreground",
      				black = "VertSplit foreground",
      				red = "Red foreground",
      				green = "Green foreground",
      				yellow = "Yellow foreground",
      				blue = "Blue foreground",
      				purple = "Purple foreground",
      				cyan = "Orange foreground",
      				white = "Normal foreground",
      				lightgrey = "Grey foreground",
      				darkgrey = "Pmenu background",
      			}
      			vim.g.bubbly_statusline = {
      				'mode',
      				'truncate',
				'path',
      				'branch',
      				'builtinlsp.diagnostic_count',
      				'divisor',
      				'filetype',
      				'progress',
      			}
		end
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		config = function()
			require('nvim-treesitter.configs').setup {
			ensure_installed = 'maintained',
			highlight = { enable = true },
			indent = { enable = true }
}
		end
	}
	use {
		'neovim/nvim-lspconfig',
		config = function()
			local lsp = require('lspconfig')
			-- List of language servers
			lsp.tsserver.setup {}
			lsp.vimls.setup {}
		end
	}
	use 'anott03/nvim-lspinstall'
	use 'tpope/vim-fugitive'
	use {
		'sainnhe/sonokai',
		config = function()
			vim.api.nvim_command('colorscheme sonokai')
		end
	}
	use {
		'kyazdani42/nvim-tree.lua',
		requires = {'kyazdani42/nvim-web-devicons'},
		config = function()
			vim.api.nvim_set_keymap(
				'n',
				'<leader>n',
				':NvimTreeToggle<CR>',
				{}
			)
		end
	}
	use 'nvim-lua/completion-nvim'
	use {'RishabhRD/nvim-lsputils', requires = {'RishabhRD/popfix'}}
	use 'nvim-lua/plenary.nvim'
	use 'mfussenegger/nvim-dap'
	use {
		'akinsho/nvim-bufferline.lua',
		requires = {'kyazdani42/nvim-web-devicons'},
		config = function()
			require('bufferline').setup {
				options = {
					mappings = true,
					diagnostics = 'nvim_lsp',
					show_buffer_close_icons = false
				}
			}
		end
	}
	use {
		'b3nj5m1n/kommentary',
		config = function()
			vim.api.nvim_set_keymap(
				'n',
				'<leader>/',
				'<Plug>kommentary_line_default',
				{}
			)
			vim.api.nvim_set_keymap(
				'n',
				'<leader>c',
				'<Plug>kommentary_motion_default',
				{}
			)
			vim.api.nvim_set_keymap(
				'v',
				'<leader>/',
				'<Plug>kommentary_visual_default',
				{}
			)
		end
	}
	use {
		'tjdevries/nlua.nvim',
		config = function()
			require('nlua.lsp.nvim').setup(require('lspconfig'), {
				-- Globals you want to tell the LSP are real :)
				globals = {'vim', 'use'}
			})
		end
	}
	use {
		'lewis6991/gitsigns.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
			require('gitsigns').setup {
				signs = {
					add = {text = '+'},
					change = {text = '~'},
					delete = {text = '-'},
					topdelete = {text = '-'},
					changedelete = {text = '≃'},
				}
			}
		end
	}
end)
