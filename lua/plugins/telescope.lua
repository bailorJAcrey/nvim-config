return {
        "nvim-telescope/telescope.nvim",
        tag = '0.1.8',
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = 'make'
            }
        },
        opts = {
        },
        config = function()
            -- Copied some code I found on this github issue https://github.com/nvim-telescope/telescope.nvim/issues/3020
            -- This dims the background anytime I use telescope, and I think it looks nice :)
            -- TODO: This doesn't work with transparent mode, some kind of fix would be nice

            if require('plugins.colorscheme').opts.transparent_mode == false then
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = "TelescopePrompt",
                    callback = function(ctx)
                        local backdropName = "TelescopeBackdrop"
                        local telescopeBufnr = ctx.buf

                        -- `Telescope` does not set a zindex, so it uses the default value
                        -- of `nvim_open_win`, which is 50: https://neovim.io/doc/user/api.html#nvim_open_win()
                        local telescopeZindex = 50

                        local backdropBufnr = vim.api.nvim_create_buf(false, true)
                        local winnr = vim.api.nvim_open_win(backdropBufnr, false, {
                            relative = "editor",
                            row = 0,
                            col = 0,
                            width = vim.o.columns,
                            height = vim.o.lines,
                            focusable = false,
                            style = "minimal",
                            zindex = telescopeZindex - 1 -- ensure it's below the reference window
                        })

                        vim.api.nvim_set_hl(0, backdropName, { bg = "#000000", default = true })
                        vim.wo[winnr].winhighlight = "Normal:" .. backdropName
                        vim.wo[winnr].winblend = 50
                        vim.bo[backdropBufnr].buftype = "nofile"

                        -- closebackdrop when the reference buffer is closed
                        vim.api.nvim_create_autocmd({ "WinClosed", "BufLeave" }, {
                            once = true,
                            buffer = telescopeBufnr,
                            callback = function()
                                if vim.api.nvim_win_is_valid(winnr) then vim.api.nvim_win_close(winnr, true) end
                                if vim.api.nvim_buf_is_valid(backdropBufnr) then
                                    vim.api.nvim_buf_delete(backdropBufnr, { force = true })
                                end
                            end
                        })
                    end
                })
            else
                vim.api.nvim_set_hl(0, "TelescopeResultsTitle", { bg = "#282828" })
                vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "#282828" })
                vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "#282828" })
                vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "#282828" })
                vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = "#282828" })
                vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "#282828" })
                vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "#282828", fg = "#282828" })
                vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "#282828", fg = "#282828" })
                vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "#282828", fg = "#282828" })
                vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "#282828", fg = "#282828" })
                vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#282828", fg = "#282828" })
            end

            -- End of copied code

            vim.keymap.set("n", "<leader>fd", require("telescope.builtin").find_files)
            vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers)

            require("telescope").setup({
                defaults = {
                    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
                    -- borderchars = { "█", "█", "█", "█", "█", "█", "█", "█" },
                },
                pickers = {
                    find_files = {
                        layout_strategy = "horizontal",
                        layout_config = {
                            preview_width = 0.6
                        },
                    },
                    buffers = {
                        layout_strategy = "vertical",
                        layout_config = {
                            width = 0.3,
                            height = 0.6,
                            preview_height = 0
                        }
                    }
                }
            })
        end
}
