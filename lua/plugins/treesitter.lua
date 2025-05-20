return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate :TSEnable highlight",
    opts = {
        ensure_installed = {
            "c",
            "cpp",
            "lua",
            "vimdoc",
            "markdown",
            "rust",
            "glsl",
            "java",
            "wit"
        },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        }
    },
}
