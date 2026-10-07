return {
    {
        "seblyng/roslyn.nvim",
        vscode = false,
        opts = {
            filewatching = "off",
            silent = true,
            extensions = {
                razor = { enabled = false },
            },
        },
        config = function(_, opts)
            require("roslyn").setup(opts)
            vim.lsp.config("roslyn", {
                handlers = {
                    ["workspace/_roslyn_projectNeedsRestore"] = function(_, result, ctx)
                        return result
                    end,
                },
            })
        end,
    },
}
