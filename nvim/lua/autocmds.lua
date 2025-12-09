local function auto_save_command()
    vim.api.nvim_create_autocmd({
        "InsertLeave",
        "TextChanged",
        "TextChangedI",
        "BufModifiedSet",
        "BufLeave",        -- Save when leaving buffer (important for :cdo)
        "CmdlineLeave",    -- Save after command execution
    }, {
        callback = function()
            if vim.bo.modified and vim.bo.buftype == "" then
                vim.cmd("silent! write")
            end
        end
    })
end

auto_save_command()
