local M = {}

local config = require("pencil.config")
local commands = require("pencil.commands")

function M.setup(user_config)
    config.setup(user_config)
    commands.setup()
end

return M
