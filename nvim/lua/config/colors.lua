local M = {}

M.light = {
  nord = {
    base = "#ECEFF4", -- Light background
    mantle = "#E5E9F0", -- Slightly darker than base
    crust = "#D8DEE9", -- Darkest background for light theme
    text = "#2E3440", -- Main text (dark)
    subtext1 = "#3B4252", -- Slightly lighter text
    subtext0 = "#434C5E", -- More lighter text
    overlay2 = "#4C566A", -- Low-emphasis text (comments, etc.)
    overlay1 = "#5E6779", -- UI elements, less prominent
    overlay0 = "#697488", -- Borders, lightest overlay
    surface2 = "#7B88A1", -- Light UI elements (panels, separators)
    surface1 = "#8C99B0", -- Medium UI elements
    surface0 = "#9DAABF", -- Lightest UI elements
    blue = "#5E81AC", -- Nord blue (darker for contrast)
    lavender = "#B48EAD", -- Nord purple
    sapphire = "#81A1C1", -- Frost darker blue
    sky = "#88C0D0", -- Frost blue
    teal = "#8FBCBB", -- Frost green-blue
    green = "#A3BE8C", -- Nord green
    yellow = "#EBCB8B", -- Nord yellow
    peach = "#D08770", -- Nord orange
    maroon = "#BF616A", -- Nord red-pink
    red = "#BF616A", -- Nord red
    mauve = "#B48EAD", -- Nord purple
    magenta = "#B48EAD", -- Nord purple
    pink = "#B48EAD", -- Nord purple
    cyan = "#88C0D0", -- Frost blue
    flamingo = "#D08770", -- Nord orange
    rosewater = "#EBCB8B", -- Nord yellow,
  },
  nordgrok = {
    -- Backgrounds (Snow Storm)
    base = "#ECEFF4", -- Nord6: Brightest white for the main background
    mantle = "#E5E9F0", -- Nord5: Slightly dimmer white for secondary backgrounds
    crust = "#D8DEE9", -- Nord4: Soft white for subtle contrasts

    -- Foregrounds (Polar Night)
    text = "#2E3440", -- Nord0: Deepest black for primary text
    subtext1 = "#3B4252", -- Nord1: Dark gray for secondary text
    subtext0 = "#434C5E", -- Nord2: Medium gray for less prominent text

    -- Overlays (Darker Polar Night shades)
    overlay2 = "#4C566A", -- Nord3: Light gray for overlays
    overlay1 = "#434C5E", -- Nord2: Medium gray
    overlay0 = "#3B4252", -- Nord1: Darker gray

    -- Surface layers (Mixed Polar Night and Frost)
    surface2 = "#5E81AC", -- Nord10: Deep blue as a subtle surface accent
    surface1 = "#4C566A", -- Nord3: Light gray for surfaces
    surface0 = "#3B4252", -- Nord1: Dark gray for base surfaces

    -- Accents (Frost and Aurora)
    rosewater = "#8FBCBB", -- Nord7: Teal-like blue for a soft accent
    flamingo = "#BF616A", -- Nord11: Red for a warm accent
    pink = "#B48EAD", -- Nord15: Purple for a playful touch
    mauve = "#5E81AC", -- Nord10: Deep blue for a cool accent
    red = "#BF616A", -- Nord11: Red reused for consistency
    maroon = "#D08770", -- Nord12: Orange for a distinct warm tone
    peach = "#D08770", -- Nord12: Orange reused for harmony
    yellow = "#EBCB8B", -- Nord13: Yellow for brightness
    green = "#A3BE8C", -- Nord14: Green for a natural feel
    teal = "#88C0D0", -- Nord8: Light blue for a frost-like teal
    sky = "#81A1C1", -- Nord9: Mid blue for a sky-like tone
    sapphire = "#5E81AC", -- Nord10: Deep blue reused
    blue = "#81A1C1", -- Nord9: Mid blue for a cool accent
    lavender = "#88C0D0", -- Nord8: Light blue for a pastel lavender
  },
  dawnfox = {
    base = "#faf4ed",
    mantle = "#ebe5df",
    crust = "#dcd7cd",
    text = "#575279",
    subtext1 = "#6e6a86",
    subtext0 = "#817c9c",
    overlay2 = "#9893a5",
    overlay1 = "#b8b3c7",
    overlay0 = "#d0ccd8",
    surface2 = "#dfdad9",
    surface1 = "#e4dfd7",
    surface0 = "#e9e4dc",
    blue = "#286983",
    lavender = "#907aa9",
    sapphire = "#56949f",
    sky = "#31748f",
    teal = "#56949f",
    green = "#618774",
    yellow = "#ea9d34",
    peach = "#d7827e",
    maroon = "#b4637a",
    red = "#b4637a",
    mauve = "#907aa9",
    magenta = "#ea9d34",
    pink = "#d7827e",
    cyan = "#56949f",
    flamingo = "#b4637a",
    rosewater = "#d7827e",
  },
  monokaiprosun = {
    base = "#fdf9f3", -- Background (light)
    mantle = "#f3efe9", -- Slightly darker background
    crust = "#e9e5df", -- Darker background variant
    text = "#37342f", -- Foreground (dark text)
    subtext1 = "#4a4740", -- Slightly lighter text
    subtext0 = "#5d5a53", -- Dimmed foreground
    overlay2 = "#726e67", -- Comments
    overlay1 = "#878580", -- Muted text
    overlay0 = "#9c9a96", -- More muted elements
    surface2 = "#b2b0ad", -- UI elements
    surface1 = "#c8c6c4", -- UI elements lighter
    surface0 = "#dedcd9", -- UI elements lightest
    blue = "#4da6ff", -- Blue
    lavender = "#a37acc", -- Purple
    sapphire = "#1aabbc", -- Teal-blue
    sky = "#4da6ff", -- Light blue
    teal = "#0fa89b", -- Teal
    green = "#87c38a", -- Green
    yellow = "#f9ae58", -- Yellow/Orange
    peach = "#fc8a4a", -- Orange
    maroon = "#f76e92", -- Pink/Red
    red = "#ed6a7d", -- Red
    mauve = "#a37acc", -- Purple
    magenta = "#f76e92", -- Pink
    pink = "#f76e92", -- Pink
    cyan = "#1aabbc", -- Cyan
    flamingo = "#fc8a4a", -- Orange
    rosewater = "#f9ae58", -- Yellow/Orange
  },
}

M.dark = {
  nord = {
    base = "#2E3440", -- Dark background
    mantle = "#2B303B", -- Slightly lighter than base
    crust = "#272C36", -- Darkest background
    text = "#ECEFF4", -- Main text
    subtext1 = "#D8DEE9", -- Slightly muted text
    subtext0 = "#C2C8D2", -- More muted text
    overlay2 = "#ADB4C0", -- Low-emphasis text
    overlay1 = "#9199A8", -- UI elements, less prominent
    overlay0 = "#7C8496", -- Borders, lightest overlay
    surface2 = "#626C84", -- Dark UI elements (panels, separators)
    surface1 = "#4C566A", -- Medium UI elements
    surface0 = "#3B4252", -- Lightest UI elements
    blue = "#81A1C1", -- Nord blue
    lavender = "#B48EAD", -- Nord purple
    sapphire = "#88C0D0", -- Frost blue
    sky = "#8FBCBB", -- Frost light green-blue
    teal = "#8FBCBB", -- Frost green-blue
    green = "#A3BE8C", -- Nord green
    yellow = "#EBCB8B", -- Nord yellow
    peach = "#D08770", -- Nord orange
    maroon = "#BF616A", -- Nord red-pink
    red = "#BF616A", -- Nord red
    mauve = "#B48EAD", -- Nord purple
    magenta = "#B48EAD", -- Nord purple
    pink = "#B48EAD", -- Nord purple
    cyan = "#88C0D0", -- Frost blue
    flamingo = "#D08770", -- Nord orange
    rosewater = "#EBCB8B", -- Nord yellow
  },
  nordgrok = {
    -- Backgrounds (Polar Night)
    base = "#2E3440", -- Nord0: Deepest black for the main background
    mantle = "#3B4252", -- Nord1: Slightly lighter for secondary backgrounds
    crust = "#434C5E", -- Nord2: Even lighter for subtle contrasts

    -- Foregrounds (Snow Storm)
    text = "#ECEFF4", -- Nord6: Brightest white for primary text
    subtext1 = "#E5E9F0", -- Nord5: Slightly dimmer white for secondary text
    subtext0 = "#D8DEE9", -- Nord4: Soft white for less prominent text

    -- Overlays (Mid-grays from Polar Night)
    overlay2 = "#4C566A", -- Nord3: Light gray for overlays
    overlay1 = "#434C5E", -- Nord2: Medium gray
    overlay0 = "#3B4252", -- Nord1: Darker gray

    -- Surface layers (Interpolated grays)
    surface2 = "#5E81AC", -- Nord10: Deep blue as a subtle surface accent
    surface1 = "#4C566A", -- Nord3: Light gray for surfaces
    surface0 = "#3B4252", -- Nord1: Dark gray for base surfaces

    -- Accents (Frost and Aurora)
    rosewater = "#8FBCBB", -- Nord7: Teal-like blue for a soft accent
    flamingo = "#BF616A", -- Nord11: Red for a warm accent
    pink = "#B48EAD", -- Nord15: Purple for a playful touch
    mauve = "#5E81AC", -- Nord10: Deep blue for a cool accent
    red = "#BF616A", -- Nord11: Red reused for consistency
    maroon = "#D08770", -- Nord12: Orange for a distinct warm tone
    peach = "#D08770", -- Nord12: Orange reused for harmony
    yellow = "#EBCB8B", -- Nord13: Yellow for brightness
    green = "#A3BE8C", -- Nord14: Green for a natural feel
    teal = "#88C0D0", -- Nord8: Light blue for a frost-like teal
    sky = "#81A1C1", -- Nord9: Mid blue for a sky-like tone
    sapphire = "#5E81AC", -- Nord10: Deep blue reused
    blue = "#81A1C1", -- Nord9: Mid blue for a cool accent
    lavender = "#88C0D0", -- Nord8: Light blue for a pastel lavender
  },
  nightfox = {
    base = "#2e3440",
    mantle = "#292e39",
    crust = "#242933",
    text = "#cdcecf",
    subtext1 = "#b6beca",
    subtext0 = "#a3adc8",
    overlay2 = "#60728a",
    overlay1 = "#5a6884",
    overlay0 = "#545f7e",
    surface2 = "#4c566a",
    surface1 = "#434c5e",
    surface0 = "#3b4252",
    blue = "#81a1c1",
    lavender = "#b48ead",
    sapphire = "#88c0d0",
    sky = "#8fbcbb",
    -- teal = "#8fbcbb",
    green = "#a3be8c",
    yellow = "#ebcb8b",
    peach = "#d08770",
    maroon = "#bf616a",
    -- red = "#bf616a",
    mauve = "#b48ead",
    -- pink = "#b48ead",
    flamingo = "#d08770",
    rosewater = "#e5e9f0",
  },
  monokaiproclassic = {
    base = "#2d2a2e", -- Main background
    mantle = "#252325", -- Slightly lighter background
    crust = "#1e1c1e", -- Darkest background
    text = "#fcfcfa", -- Main text
    subtext1 = "#b8b3c7", -- Darkest subtext, closest to text
    subtext0 = "#c1ba91", -- Slightly lighter than subtext1
    overlay2 = "#a59f85", -- Low-emphasis text
    overlay1 = "#a1a1a1", -- UI elements, less prominent
    overlay0 = "#9893a5", -- Borders, lightest overlay
    surface2 = "#727072", -- Dark UI elements (panels, separators)
    surface1 = "#5b595c", -- Medium UI elements
    surface0 = "#403e41", -- Lightest UI elements
    blue = "#66d9ef", -- Blue
    lavender = "#ae81ff", -- Soft purple
    sapphire = "#78dce8", -- Cyan-blue mix
    sky = "#66d9ef", -- Light blue
    teal = "#78dce8", -- Cyan (same as sapphire)
    green = "#a6e22e", -- Green
    yellow = "#e6db74", -- Yellow
    peach = "#fd971f", -- Orange
    maroon = "#fd5ff0", -- Magenta/pink mix
    red = "#f92672", -- Red
    mauve = "#ae81ff", -- Purple
    magenta = "#fd971f", -- Orange (close to Monokai's accent)
    pink = "#ff6188", -- Pink
    cyan = "#78dce8", -- Cyan
    flamingo = "#f92672", -- Same as red
    rosewater = "#ff6188", -- Soft pink
  },
  monokaipromachine = {
    base = "#273136", -- Background
    mantle = "#1e2428", -- Slightly darker background
    crust = "#1a2023", -- Darkest background
    text = "#f2fffc", -- Foreground text
    subtext1 = "#c1c6c8", -- Dimmed foreground
    subtext0 = "#9fa7a9", -- More dimmed foreground
    overlay2 = "#6e7a7d", -- Comments
    overlay1 = "#546063", -- Line highlight
    overlay0 = "#3a4449", -- Selection background
    surface2 = "#32393d", -- UI elements
    surface1 = "#2a3034", -- UI elements darker
    surface0 = "#222a2e", -- UI elements darkest
    blue = "#5ad4e6", -- Cyan/Blue
    lavender = "#948ae3", -- Purple
    sapphire = "#7cd5f1", -- Light blue
    sky = "#5ad4e6", -- Cyan
    teal = "#4cd2c9", -- Teal
    green = "#a7e160", -- Green
    yellow = "#ffd76d", -- Yellow
    peach = "#fd9353", -- Orange
    maroon = "#ff6d7e", -- Light red
    red = "#ff6d7e", -- Red
    mauve = "#948ae3", -- Purple
    magenta = "#ff6d7e", -- Pink/Magenta
    pink = "#ff6d7e", -- Pink
    cyan = "#5ad4e6", -- Cyan
    flamingo = "#fd9353", -- Light orange
    rosewater = "#ffbb77", -- Light yellow
  },
}

return M

-- frappe = {
--   lavender = utils.darken(frappe.lavender, 0.85, frappe.base),
--   mauve = utils.darken(frappe.mauve, 0.85, frappe.base),
--   -- mauve = desaturate(frappe.mauve, 0.1),
--   green = utils.darken(frappe.green, 0.85, frappe.base),
--   peach = utils.darken(frappe.peach, 0.85, frappe.base),
--   yellow = utils.darken(frappe.yellow, 0.85, frappe.base),
--   --
--   subtext1 = utils.darken(frappe.subtext1, 0.65, frappe.base),
--   subtext0 = utils.darken(frappe.subtext0, 0.65, frappe.base),
--   overlay2 = utils.darken(frappe.overlay2, 0.65, frappe.base),
--   overlay1 = utils.darken(frappe.overlay1, 0.65, frappe.base),
--   overlay0 = utils.darken(frappe.overlay0, 0.65, frappe.base),
--   surface2 = utils.darken(frappe.surface2, 0.65, frappe.base),
--   surface1 = utils.darken(frappe.surface1, 0.65, frappe.base),
--   surface0 = utils.darken(frappe.surface0, 0.65, frappe.base),
--   --
--   text = utils.darken(frappe.text, 0.85, frappe.base),
-- },
--
-- subtext1
-- subtext0
-- overlay2
-- overlay1
-- overlay0
-- surface2
-- surface1
-- surface0
