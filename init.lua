-- Helpers
local execute = vim.api.nvim_command
local fn = vim.fn
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- Install Packer if not already installed

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
	execute 'packadd packer.nvim'
end

-- Use configurations
require('plugins')
require('treesitterconfig')
require('languageserverconfig')


-- Completion setup
vim.cmd 'autocmd BufEnter * lua require"completion".on_attach()'

-- Automatically compile and install Packer plugins
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile'
vim.cmd 'autocmd BufWritePost plugins.lua PackerSync'

-- Options
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('o', 'completeopt', 'menuone,noinsert,noselect')  -- Completion options
opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('w', 'number', true)                              -- Print line number

-- Completion mappings
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
map('i', '<C-Space>', '<Plug>(completion_trigger)',{
		silent = true,
		noremap = false
	}
)

-- LSP mappings
map('n', '<Space>,', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<Space>;', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<Space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<Space>d', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', '<Space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<Space>h', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<Space>m', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<Space>r', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', '<Space>s', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')

