return {
    "nvimdev/lspsaga.nvim",
    config = function()
        require("lspsaga").setup({})
        vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
        vim.keymap.set("n", "<leader>cb", "<cmd>Lspsaga term_toggle<CR>", { silent = true })
    end,
}
