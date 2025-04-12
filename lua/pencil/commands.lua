local wrap = require("pencil.wrap")
local autoformat = require("pencil.autoformat")
local utils = require("pencil.utils")
local state = require("pencil.state")
local M = {}

-- TODO: Implement actual wrap mode detection. This is currently just a placeholder.
local function auto_detect_wrap_mode()
    local detected_mode = "hard"
    if detected_mode == "soft" then
        wrap.enable_soft_wrap()
    else
        wrap.enable_hard_wrap()
    end
    utils.log_warning("Auto-detection is currently a placeholder and defaults to hard wrap.")
    state.pencil_enabled = true
    utils.log_states()
end

function M.pencil()
    auto_detect_wrap_mode()
end

function M.no_pencil()
    wrap.disable_wrap()
    state.pencil_enabled = false
    utils.log_states()
end

function M.toggle_pencil()
    if state.pencil_enabled then
        M.no_pencil()
    else
        M.pencil()
    end
end

function M.soft_pencil()
    wrap.enable_soft_wrap()
    state.pencil_enabled = true
    utils.log_states()
end

function M.hard_pencil()
    wrap.enable_hard_wrap()
    state.pencil_enabled = true
    utils.log_states()
end

function M.setup()
    local commands = {
        { "Pencil", M.pencil },
        { "NoPencil", M.no_pencil },
        { "PencilOff", M.no_pencil },
        { "PencilToggle", M.toggle_pencil },
        { "TogglePencil", M.toggle_pencil },
        { "SoftPencil", M.soft_pencil },
        { "PencilSoft", M.soft_pencil },
        { "HardPencil", M.hard_pencil },
        { "PencilHard", M.hard_pencil },
    }

    for _, cmd in ipairs(commands) do
        vim.api.nvim_create_user_command(cmd[1], cmd[2], {})
    end
end

return M
