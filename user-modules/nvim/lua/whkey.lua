
require("which-key").setup{}

-- TODO: add telescope and lsp keybinds
require("which-key").register({
    f = {
        name = "file", -- optional group name
        f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
    },
    l = {
        name = "lsp", -- optional group name
        f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" }, -- create a binding with label
    }
}, { prefix = "<leader>" })
