local severity = vim.diagnostic.severity

vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "if_many",
    },
    underline = {
        severity = { min = severity.WARN },
    },
    virtual_text = true,
    virtual_lines = false,
    signs = {
        text = {
            [severity.ERROR] = " ",
            [severity.WARN] = " ",
            [severity.HINT] = "󰠠 ",
            [severity.INFO] = " ",
        },
    },
})
