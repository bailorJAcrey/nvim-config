local termSize = 12
vim.keymap.set("n", "<C-Tab>", vim.cmd.ToggleTerm)
vim.api.nvim_create_autocmd({"BufEnter", "TermOpen"}, {
    pattern = "term://*#toggleterm#*",
    callback = function()
        vim.opt_local.cul = false
        vim.opt_local.laststatus = 0
        vim.cmd(tostring(termSize).."wincmd _")
    end
})
vim.api.nvim_create_autocmd("BufHidden", {
    pattern = "term://*#toggleterm#*",
    callback = function()
        vim.opt.cul = true
        vim.opt.laststatus = 2
    end
})

return {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
        size = termSize,
        shade_terminals = false
    }
}
