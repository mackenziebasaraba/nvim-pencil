local config = require("pencil.config")
local utils = require("pencil.utils")
local autoformat = require("pencil.autoformat")

local M = {}

local function set_cursor_wrap(enabled)
    if enabled then
        vim.keymap.set("n", "<Up>", "gk", { silent = true, noremap = true, desc = "Move up a visual line" })
        vim.keymap.set("n", "<Down>", "gj", { silent = true, noremap = true, desc = "Move down a visual line" })
        vim.keymap.set("i", "<Up>", "<C-o>gk", { silent = true, noremap = true, desc = "Move up a visual line in Insert mode" })
        vim.keymap.set("i", "<Down>", "<C-o>gj", { silent = true, noremap = true, desc = "Move down a visual line in Insert mode" })
    else
        vim.keymap.del("n", "<Up>")
        vim.keymap.del("n", "<Down>")
        vim.keymap.del("i", "<Up>")
        vim.keymap.del("i", "<Down>")
    end
end


function M.enable_soft_wrap()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.showbreak = config.options.show_break_symbol
    set_cursor_wrap(config.options.cursor_wrap)
    utils.log_warning("Soft wrap mode enabled.")
end

function M.enable_hard_wrap(text_width)
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = false
    vim.opt_local.textwidth = text_width or config.options.text_width

    if utils.get_option("autoformat", true) then
        autoformat.enable_autoformat()
        utils.log_warning("Hard wrap mode enabled with autoformat.")
    else
        autoformat.disable_autoformat()
        utils.log_warning("Hard wrap mode enabled without autoformat.")
    end

    set_cursor_wrap(config.options.cursor_wrap)
end

function M.disable_wrap()
    vim.opt_local.wrap = false
    vim.opt_local.linebreak = false
    vim.opt_local.textwidth = 0
    autoformat.disable_autoformat()
    set_cursor_wrap(false)
    utils.log_warning("Wrapping disabled (off mode).")
end

function M.set_wrap_mode(mode, text_width)
    if not utils.is_valid_wrap_mode(mode) then
        utils.log_warning("Invalid wrap mode: " .. mode)
        return
    end

    if mode == "soft" then
        M.enable_soft_wrap()
    elseif mode == "hard" then
        M.enable_hard_wrap(text_width)
    elseif mode == "off" then
        M.disable_wrap()
    end
end

return M
