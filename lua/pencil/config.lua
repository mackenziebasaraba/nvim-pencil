local M = {}

-- Default config
M.options = {
    wrap_mode_default = "hard", -- "soft", "hard", or "off"
    text_width = 74, -- Chosen for compatibility with email clients/Markdown renderers
    autoformat = true,
    autoformat_rules = {
        markdown = {
            blacklist = {
                "htmlH[0-9]",
                "markdownCode",
                "markdownFencedCodeBlock",
                "markdownInlineCode",
                "markdownRule",
                "markdownH[0-9]",
                "mkdCode",
                "mmdTable[A-Za-z0-9]*",
            },
            whitelist = {
                "markdownLink",
            },
        },
        asciidoc = {
            blacklist = {
                "asciidoc(AttributeList|AttributeEntry|ListLabel|Literal|SideBar|Source|Sect[0-9])",
                "asciidoc[A-Za-z]*(Block|Macro|Title)",
            },
            whitelist = {
                "asciidoc(AttributeRef|Macro)",
            },
            enforce_previous_line = true,
        },
        rst = {
            blacklist = {
                "rst(CodeBlock|Directive|ExDirective|LiteralBlock|Sections)",
                "rst(Comment|Delimiter|ExplicitMarkup|SimpleTable)",
            },
        },
        tex = {
            blacklist = {
                "tex(BeginEndName|Delimiter|DocType|InputFile|Math|RefZone|Statement|Title)",
                "texSection$",
            },
            enforce_previous_line = true,
        },
        textile = {
            blacklist = {
                "txtCode",
            },
        },
        pandoc = {
            blacklist = {
                "^pandoc.*Code.*",
                "pandocHTML",
                "pandocLaTeXMathBlock",
                "^pandoc.*List.*",
                "^pandoc.*Table.*",
                "pandocYAMLHeader",
            },
        },
    },
    join_spaces = false, -- Use a single space after periods **DOES NOT DO ANYTHING YET**
    cursor_wrap = true, -- Enable cursor movement between soft line breaks with arrow keys
    cursor_wrap_enable_jk = false, -- Enables cursor movement between soft line breaks with J and K
    conceal_level = 2,
    conceal_cursor = "c", -- Conceals cursor in chosen modes (e.g., "c", "n", "v", "i"). **DOES NOT DO ANYTHING YET&**
    show_break_symbol = ">", -- Visual marker for soft-wrapped lines
    soft_detect_sample = 20, -- Lines to sample for soft wrap detection **DOES NOT DO ANYTHING YET**
    soft_detect_threshold = 130, -- Maximum byte threshold for soft wrap detection. **DOES NOT DO ANYTHING YET**
    mode_indicators = {
        hard = "H",
        soft = "S",
        auto = "A",
        off = "",
    },
}

function M.setup(user_config)
    local valid_modes = { "soft", "hard", "off" }
    if user_config and user_config.wrap_mode_default and not vim.tbl_contains(valid_modes, user_config.wrap_mode_default) then
        error("Invalid wrap_mode_default: " .. user_config.wrap_mode_default .. ". Valid options are 'soft', 'hard', or 'off'.")
    end

    M.options = vim.tbl_deep_extend("force", M.options, user_config or {})
end

return M
