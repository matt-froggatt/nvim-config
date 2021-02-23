-- TODO:
-- 	- extract configs to where they are needed (i.e. only
-- 	  configure something when I add it, not in this file)
-- 	- make testing work
--	- try this config out

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
		execute 'PackerCompile'
		execute 'PackerInstall'
	end

	-- Use configurations
	require('plugins')

	-- Completion setup
	cmd 'autocmd BufEnter * lua require"completion".on_attach()'

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
	vim.wo.signcolumn = 'yes'			-- Always show sign column
	vim.wo.number = true				-- Print line number
	vim.bo.smartindent = true			-- Insert indents automatically

	-- Completion mappings
	map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})
	map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
	map('i', '<C-Space>', '<Plug>(completion_trigger)',{
			silent = true,
			noremap = false
		}
	)

	-- LSP mappings
	map('n', '<leader>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
	map('n', '<leader>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
	map('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
	map('n', '<leader>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
	map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
	map('n', '<leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
	map('n', '<leader>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
	map('n', '<leader>r', '<cmd>lua vim.lsp.buf.references()<CR>')
	map('n', '<leader>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

	-- LSP Utils config
	lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
	lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
	lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
	lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
	lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
	lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
	lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
	lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

	-- Netrw config
	vim.g.netrw_liststyle = 3
	vim.g.netrw_banner = 0
	vim.g.netrw_browse_split = 4
	vim.g.netrw_winsize = 25
	map('n', '<leader>n', '<cmd>Lexplore<CR>')

	-- Remove background on sign column
	execute 'highlight clear SignColumn'

end

