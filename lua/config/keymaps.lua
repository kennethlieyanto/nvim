vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without dirtying current register" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to plus register" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "yank plus register" })

vim.keymap.set("n", "<C-f>", function()
    local out = vim.fn.system({ "herdr", "tab", "create", "--focus", "--cwd", vim.fn.getcwd() })
    if vim.v.shell_error ~= 0 then
        vim.notify("Failed to create herdr tab", vim.log.levels.ERROR)
        return
    end
    local ok, decoded = pcall(vim.json.decode, out)
    local result = ok and decoded.result
    local pane = result and result.root_pane and result.root_pane.pane_id
    local tab = result and result.tab and result.tab.tab_id
    if not pane or not tab then
        vim.notify("Failed to parse herdr tab response", vim.log.levels.ERROR)
        return
    end
    local close = "herdr tab close " .. tab
    local cmd = "sh -c 'trap \"" .. close .. "\" INT TERM; herdr-sessionizer; " .. close .. "'"
    vim.fn.system({ "herdr", "pane", "run", pane, cmd })
end, { desc = "Open herdr sessionizer in new tab" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete to plus register" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<C-q>", "<cmd>only<CR>")

-- Close all splits with unlisted buffers
vim.keymap.set("n", "<C-k>", function()
    for win = vim.fn.winnr("$"), 1, -1 do
        local buf = vim.fn.winbufnr(win)
        if vim.fn.buflisted(buf) == 0 then
            vim.cmd(win .. "wincmd w")
            vim.cmd("close")
        end
    end
    vim.cmd("stopinsert")
end, { desc = "Close unlisted buffer splits" })

local diagnostic_goto = function(next, severity)
    local count = next and 1 or -1
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        vim.diagnostic.jump({ count = count, severity = severity })
    end
end

vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- Stay in visual mode when shifting
vim.keymap.set("x", "<", "<gv", { noremap = true, silent = true })
vim.keymap.set("x", ">", ">gv", { noremap = true, silent = true })

-- Move by visual lines when wrap is enabled
vim.keymap.set("n", "j", "gj", { desc = "Move down by visual line" })
vim.keymap.set("n", "k", "gk", { desc = "Move up by visual line" })

vim.keymap.set("n", "<leader>wx", function()
    vim.cmd("Lazy")
end)

-- Execute the current line/selection as Lua
vim.keymap.set("n", "<space>x", ":.lua<CR>", { desc = "Execute line as Lua" })
vim.keymap.set("v", "<space>x", ":lua<CR>", { desc = "Execute selection as Lua" })
