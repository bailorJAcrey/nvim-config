vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<C-s>", vim.cmd.w)
vim.keymap.set("n", "<leader>|", vim.cmd.vsp)
vim.keymap.set("n", "<leader>-", vim.cmd.sp)
vim.keymap.set( {"n", "i", "v"}, "<C-h>", function() vim.cmd [[wincmd h]] end)
vim.keymap.set( {"n", "i", "v"}, "<C-j>", function() vim.cmd [[wincmd j]] end)
vim.keymap.set( {"n", "i", "v"}, "<C-k>", function() vim.cmd [[wincmd k]] end)
vim.keymap.set( {"n", "i", "v"}, "<C-l>", function() vim.cmd [[wincmd l]] end)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.laststatus = 2
vim.opt.cmdheight = 1
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.signcolumn = 'no'

vim.api.nvim_create_autocmd("VimResized", {
    pattern = {'*'},
    callback = function(event)
        print(string.format("columns: %n", event.columns))
        print(string.format("lines: %n", event.lines))
        print("hello?")
    end
})

vim.diagnostic.config({
    update_in_insert = true,
    virtual_text = true,
    signs = {text = {
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = "",
    }}
})

require("lazy-nvim")

vim.cmd.colorscheme("gruvbox")
vim.cmd.TSEnable("highlight")
-- Setting highlight to 'true' in treesitter.lua doesn't enable highlighting for all parsers

local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities(),
    require('blink.cmp').get_lsp_capabilities()
)

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}
    end
})

local lspconfig = require('lspconfig')
lspconfig.rust_analyzer.setup({})
lspconfig.lua_ls.setup({})
-- lspconfig.jdtls.setup({ cmd = { "jdt-language-server", "-data", vim.cmd.pwd } })
