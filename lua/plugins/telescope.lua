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
        opts = {},
        config = function()
            vim.keymap.set("n", "<leader>fd", require("telescope.builtin").find_files)
            vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers)

            require("telescope").setup({
                defaults = {
                    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
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
