if vim.g.vscode == nil then

	-- Helpers
	local execute = vim.api.nvim_command
	local fn = vim.fn
	local cmd = vim.cmd
	local lsp = vim.lsp

	local function map(mode, lhs, rhs, opts)
	  local options = {noremap = true}
	  if opts then options = vim.tbl_extend('force', options, opts) end
	  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
	end

	-- Set leader key
	vim.g.mapleader = ' '

	-- Install Packer if not already installed

	local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

	if fn.empty(fn.glob(install_path)) > 0 then
		-- Install Packer
		execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
		execute 'packadd packer.nvim'

		-- Install Packer plugins
		require('plugins')
		execute 'PackerClean'
		execute 'PackerCompile'
		execute 'PackerInstall'
	end

	-- Use configurations
	require('plugins')

	-- Automatically compile and install Packer plugins
	cmd 'autocmd BufWritePost plugins.lua lua require("plenary.reload").reload_module("plugins")'
	cmd 'autocmd BufWritePost plugins.lua lua require("plugins")'
	cmd 'autocmd BufWritePost plugins.lua PackerCompile'
	cmd 'autocmd BufWritePost plugins.lua PackerInstall'
	cmd 'autocmd BufWritePost plugins.lua PackerClean'

	-- Options
	vim.o.completeopt = 'menuone,noinsert,noselect'	-- Completion options
	vim.o.splitbelow = true				-- Put new windows below current
	vim.o.splitright = true				-- Put new windows right of current
	vim.o.termguicolors = true			-- Use guicolors in terminal
	vim.wo.signcolumn = 'yes'			-- Always show sign column
	vim.wo.number = true				-- Print line number
	vim.bo.smartindent = true			-- Insert indents automatically

	-- Remove background on sign column
	execute 'highlight clear SignColumn'

end

