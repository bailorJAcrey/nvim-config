return {
    "Saghen/blink.cmp",
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'default',
            ['<C-space>'] = {},
            ['<C-d>'] = { 'show', 'show_documentation', 'hide_documentation' },
        },

        appearance = {
            nerd_font_variant = 'normal'
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = { documentation = { auto_show = false } },

        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
