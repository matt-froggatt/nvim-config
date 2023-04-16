vim.cmd [[packadd packer.nvim]]

vim.g.kommentary_create_default_mappings = false

return require('packer').startup(function()
	use {'wbthomason/packer.nvim', opt = true}
	use 'nvim-lua/plenary.nvim'
end)
