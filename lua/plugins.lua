vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use {'wbthomason/packer.nvim', opt = true}
	use 'nvim-treesitter/nvim-treesitter'
	use 'neovim/nvim-lspconfig'
	use 'anott03/nvim-lspinstall'
	use 'nvim-lua/completion-nvim'
	use {'RishabhRD/nvim-lsputils', requires = {'RishabhRD/popfix'}}
	use 'nvim-lua/plenary.nvim'
	use 'mfussenegger/nvim-dap'
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
