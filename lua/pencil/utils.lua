local config = require("pencil.config")
local state = require("pencil.state")

local M = {}

function M.get_option(option_name, default_value)
    local value = config.options[option_name]
    return value ~= nil and value or default_value
end

function M.is_valid_wrap_mode(mode)
    local valid_modes = { "soft", "hard", "off" }
    for _, valid_mode in ipairs(valid_modes) do
        if mode == valid_mode then
            return true
        end
    end
    return false
end

local function format_log_message(level, message)
    return string.format("[Pencil %s]: %s", level, message)
end

function M.log_warning(message)
    vim.api.nvim_echo({ { format_log_message("Warning", message), "WarningMsg" } }, true, {})
end

function M.log_error(message)
    vim.api.nvim_echo({ { format_log_message("Error", message), "ErrorMsg" } }, true, {})
end

function M.log_states()
    local states = {}

    if state.pencil_enabled then
        table.insert(states, "Pencil: Enabled")
    else
        table.insert(states, "Pencil: Disabled")
    end

    if state.autoformat_enabled then
        table.insert(states, "AutoFormat: Enabled")
    else
        table.insert(states, "Autoformat: Disabled")
    end

    if vim.opt_local.wrap:get() then
        if vim.opt_local.linebreak:get() then
            table.insert(states, "Wrap Mode: Soft")
        else
            table.insert(states, "Wrap Mode: Hard")
        end
    else
        table.insert(states, "Wrap Mode: Disabled")
    end

    local message = table.concat(states, " | ")
    vim.notify(message, vim.log.levels.INFO)
end

function M.safe_call(func, ...)
    if type(func) == "function" then
        local ok, result = pcall(func, ...)
        if not ok then
            M.log_error("Error during function call: " .. result)
        end
        return result
    else
        M.log_warning("Attempted to call a non-function value.")
    end
end

function M.trim(s)
    return s:match("^%s*(.-)%s*$")
end

function M.starts_with(str, prefix)
    return str:sub(1, #prefix) == prefix
end

function M.ends_with(str, suffix)
    return str:sub(-#suffix) == suffix
end

return M
