return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '|', right = '|' },
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = {"mode"},
            lualine_b = {},
            lualine_c = {
                {
                    "filetype",
                    icon_only = false,
                    icon = { align = "right" }
                },
                "filename",
            },
            lualine_x = {"encoding"},
            lualine_y = {"branch"},
            lualine_z = {"location"}
        }
    }
}
