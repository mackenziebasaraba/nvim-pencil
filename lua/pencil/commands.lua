local wrap = require("pencil.wrap")
local autoformat = require("pencil.autoformat")
local utils = require("pencil.utils")

local M = {}

-- TODO: Implement actual wrap mode detection. This is currently just a placeholder.
local function auto_detect_wrap_mode()
    local detected_mode = "hard"
    if detected_mode == "soft" then
        wrap.enable_soft_wrap()
        utils.log_warning("Pencil initialized with soft wrap mode (auto-detect).")
    else
        wrap.enable_hard_wrap()
        utils.log_warning("Pencil initialized with hard wrap mode (auto-detect).")
    end
    utils.log_warning("Auto-detection is currently a placeholder and defaults to hard wrap.")
end

function M.pencil()
    auto_detect_wrap_mode()
end

function M.no_pencil()
    wrap.disable_wrap()
    utils.log_warning("Pencil disabled. Buffer reverted to global settings.")
end

local pencil_enabled = false
function M.toggle_pencil()
    if pencil_enabled then
        M.no_pencil()
        pencil_enabled = false
    else
        auto_detect_wrap_mode()
        pencil_enabled = true
    end
end

function M.soft_pencil()
    wrap.enable_soft_wrap()
    utils.log_warning("Pencil initialized with soft wrap mode.")
end

function M.hard_pencil()
    wrap.enable_hard_wrap()
    autoformat.enable_autoformat()
    utils.log_warning("Pencil initialized with hard wrap mode.")
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
