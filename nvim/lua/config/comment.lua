require('Comment').setup{
    ---Add a space b/w comment and the line
    padding = true,

    -- LHS of operator-pending mapping in NORMAL + VISUAL mode
    opleader = {
      -- line-comment keymap
      line = "gc",
      -- block-comment keymap
      block = "gb",
    },

   -- Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
    mappings = {
      -- operator-pending mapping
      -- Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
      basic = true,

      -- extra mapping
      -- Includes `gco`, `gcO`, `gcA`
      extra = true,

      -- extended mapping
      -- Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
      extended = false,
    },

}
