require("config.options")
require("config.diagnostics")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")

if vim.g.vscode then
    require("config.vscode-keymaps")
end
