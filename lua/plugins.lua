vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use {'wbthomason/packer.nvim', opt = true}
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
	use 'nvim-lua/completion-nvim'
	use {'RishabhRD/nvim-lsputils', requires = {'RishabhRD/popfix'}}
	use 'nvim-lua/plenary.nvim'
	use 'mfussenegger/nvim-dap'
	use {
		'tjdevries/nlua.nvim',
		config = function()
			require('nlua.lsp.nvim').setup(require('lspconfig'), {
				-- Include globals you want to tell the LSP are real :)
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
