local function auto_save_command()
    vim.api.nvim_create_autocmd({
        "InsertLeave",
        "TextChanged",
        "TextChangedI",
        "BufModifiedSet"
    }, {
        callback = function()
            if vim.bo.modified and vim.bo.buftype == "" then
                vim.cmd("silent! write")
            end
        end
    })
end

auto_save_command()
