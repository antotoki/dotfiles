-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local function gf_keep_terminal(self)
    local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
    if f == "" then
        Snacks.notify.warn("No file under cursor")
        return
    end
    vim.cmd("wincmd p") -- jump to the window you were in before opening the terminal
    vim.cmd.edit(f)
end

local function dotnet_term_win()
    return {
        position = "bottom",
        keys = { gf = gf_keep_terminal },
    }
end

local function run_dotnet(command)
    local terminal = Snacks.terminal.open(vim.o.shell, { win = dotnet_term_win() })

    vim.schedule(function()
        if terminal and vim.api.nvim_buf_is_valid(terminal.buf) then
            vim.api.nvim_chan_send(vim.bo[terminal.buf].channel, command .. "\n")
        end
    end)
end

vim.keymap.set("n", "<leader>db", function()
    run_dotnet("dotnet build")
end, { desc = "dotnet build" })

vim.keymap.set("n", "<leader>dB", function()
    run_dotnet("dotnet clean && dotnet build -p:EnforceCodeStyleInBuild=true")
end, { desc = "dotnet clean && build" })
-- vim.keymap.set("n", "<leader>db", function()
--     vim.notify("Running dotnet build...", vim.log.levels.INFO)
--     local output = {}
--     vim.fn.jobstart("dotnet build", {
--         stdout_buffered = true,
--         stderr_buffered = true,
--         on_stdout = function(_, data)
--             vim.list_extend(output, data)
--         end,
--         on_stderr = function(_, data)
--             vim.list_extend(output, data)
--         end,
--         on_exit = function(_, code)
--             vim.fn.setqflist({}, " ", {
--                 title = "dotnet build",
--                 lines = output,
--                 efm = vim.o.errorformat,
--             })
--             if code == 0 then
--                 vim.notify("Build succeeded", vim.log.levels.INFO)
--             else
--                 vim.cmd("copen")
--             end
--         end,
--     })
-- end, { desc = "Dotnet Build (async, quickfix)" })
