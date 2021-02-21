-- Install Packer if not already installed
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
	execute 'packadd packer.nvim'
end

-- Use configurations
require('plugins')
require('treesitterconfig')

-- Automatically compile and install Packer plugins
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'
vim.cmd 'autocmd BufWritePost plugins.lua PackerSync'

-- LSP setup
local lsp = require('lspconfig')
lsp.sumneko_lua.setup {}
