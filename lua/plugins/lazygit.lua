vim.g.lazygit_floating_window_border_chars = {'', '', '', '', '', '', '', ''}
if require('plugins.colorscheme').opts.transparent_mode == false then
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "lazygit",
        callback = function(ctx)
            local backdropName = "LazygitBackdrop"
            local lazygitBufnr = ctx.buf
            local lazygitZindex = 50
            local backdropBufnr = vim.api.nvim_create_buf(false, true)
            local winnr = vim.api.nvim_open_win(backdropBufnr, false, {
                relative = "editor",
                row = 0,
                col = 0,
                width = vim.o.columns,
                height = vim.o.lines,
                focusable = false,
                style = "minimal",
                zindex = lazygitZindex - 1
            })

            vim.api.nvim_set_hl(0, backdropName, { bg = "#000000", default = true })
            vim.wo[winnr].winhighlight = "Normal:" .. backdropName
            vim.wo[winnr].winblend = 50
            vim.bo[backdropBufnr].buftype = "nofile"

            vim.api.nvim_create_autocmd({ "WinClosed", "BufLeave" }, {
                once = true,
                buffer = lazygitBufnr,
                callback = function()
                    if vim.api.nvim_win_is_valid(winnr) then vim.api.nvim_win_close(winnr, true) end
                    if vim.api.nvim_buf_is_valid(backdropBufnr) then
                        vim.api.nvim_buf_delete(backdropBufnr, { force = true })
                    end
                end
            })
        end
    })
end


return {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
}
