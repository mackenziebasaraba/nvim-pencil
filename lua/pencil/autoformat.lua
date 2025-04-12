local utils = require("pencil.utils")
local state = require("pencil.state")

local M = {}

-- I'll be frank: autoformat exclusions don't work. I'll get around to fixing
-- them soon. Sorry, lads.

function M.enable_autoformat()
    if not utils.get_option("autoformat", false) then
        utils.log_error("Autoformat is disabled in your configuration.")
        return
    end

    vim.opt.formatoptions:append("t")
    vim.opt.formatoptions:append("q")
    vim.opt.formatoptions:append("j")
    vim.opt.formatoptions:append("n")

    state.autoformat_enabled = true
end

function M.disable_autoformat()
    vim.opt.formatoptions:remove("t")
    vim.opt.formatoptions:remove("q")
    vim.opt.formatoptions:remove("j")
    vim.opt.formatoptions:remove("n")

    state.autoformat_enabled = false
end

return M
