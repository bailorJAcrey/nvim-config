return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            keymaps = {
                ["<C-h>"] = false,
                ["<C-l>"] = false,
            },
            view_options = {
                show_hidden = true;
            }
        })
        vim.keymap.set("n", "<leader>e", vim.cmd.Oil)
    end
}
