-- LSP setup
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local lsp = require('lspconfig')
local sumneko_root_path = vim.fn.stdpath('data')..'/lspinstall/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"
lsp.sumneko_lua.setup{
	cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
}
lsp.tsserver.setup {}
lsp.vimls.setup {}


