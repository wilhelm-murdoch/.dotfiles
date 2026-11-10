-- wilhelm.codes, a lualine theme
--
-- Every colour is a token from assets/css/main.css. lualine picks this file
-- up on its own when the colorscheme is wilhelm-codes and the theme is auto.
--
-- The mode block is the one lit thing on the line. Normal mode wears the
-- accent, since the accent means live, current or mine. The other modes
-- wear a bit kind each, so a mode change reads at the edge of sight.

local p = {
  bg = "#17181a",        -- --bg
  bg_elev = "#1e1f22",   -- --bg-elev
  bg_sunk = "#202225",   -- --bg-sunk
  text = "#e3e3de",      -- --text
  soft = "#b9b9b2",      -- --text-soft
  muted = "#8b8b84",     -- --text-muted
  faint = "#6a6a64",     -- --text-faint
  accent = "#32d74b",    -- --accent
  heart = "#ff6369",     -- --heart
  blue = "#7ea6ff",      -- --bit-blue
  emerald = "#4ade9f",   -- --bit-emerald
  amber = "#f2b45c",     -- --bit-amber
  violet = "#c08aff",    -- --bit-violet
}

local function mode(colour)
  return {
    a = { fg = p.bg, bg = colour, gui = "bold" },
    b = { fg = p.soft, bg = p.bg_sunk },
    c = { fg = p.muted, bg = p.bg_elev },
  }
end

local theme = {
  normal = mode(p.accent),
  insert = mode(p.blue),
  visual = mode(p.violet),
  replace = mode(p.heart),
  command = mode(p.amber),
  terminal = mode(p.emerald),
  inactive = {
    a = { fg = p.faint, bg = p.bg_elev },
    b = { fg = p.faint, bg = p.bg_elev },
    c = { fg = p.faint, bg = p.bg_elev },
  },
}

return theme
