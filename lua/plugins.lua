vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use {'wbthomason/packer.nvim', opt = true}
	use 'nvim-treesitter/nvim-treesitter'
	use 'neovim/nvim-lspconfig'
	use 'anott03/nvim-lspinstall'
	use 'nvim-lua/completion-nvim'
	use 'RishabhRD/nvim-lsputils'
	use 'RishabhRD/popfix'
	use 'airblade/vim-gitgutter'
end)
