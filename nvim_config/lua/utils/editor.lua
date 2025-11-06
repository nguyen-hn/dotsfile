local M = {}

function M.AddDefineBlock()
    local current_mode = vim.api.nvim_get_mode().mode
    local opts = {}

    if current_mode == 'v' or current_mode == 'V' or current_mode == 'CTRL-V' then
        opts.type = current_mode
        local old_reg = vim.fn.getreg('x')

        local selected_text = vim.fn.getreg(vim.fn.getpos('v'), vim.fn.getpos('.'), opts)

        print(selected_text)
    end
end

return M
