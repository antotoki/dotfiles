return {
    {
        "mason-org/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup({
                ui = { border = "rounded" },
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry", -- Custom registry for Roslyn
                },
            })
        end,
    },
}
