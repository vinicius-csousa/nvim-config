--require("toggleterm").setup({
  --size = function(term)
    --if term.direction == "horizontal" then
      --return 15
    --elseif term.direction == "vertical" then
      --return math.floor(vim.o.columns * 0.4)
    --end
  --end,
  --open_mapping = [[<leader>Tt]], -- fallback mapping
  --hide_numbers = true,
  --shade_terminals = true,
  --shading_factor = 1,
  --start_in_insert = true,
  --insert_mappings = false,
  --persist_size = true,
  --persist_mode = true,
  --direction = "horizontal", -- default
  --close_on_exit = true,
  --shell = vim.o.shell,
  --float_opts = {
    --border = "curved",
    --winblend = 3,
    --title_pos = "center",
  --},
--})

---- =========================
---- 🔄 Terminal management
---- =========================
--local Terminal = require("toggleterm.terminal").Terminal

---- Create dedicated instances
--local term_horizontal = Terminal:new({ direction = "horizontal" })
--local term_vertical = Terminal:new({ direction = "vertical" })
--local term_float = Terminal:new({ direction = "float" })

---- Toggle functions
--function _TOGGLE_HORIZONTAL()
  --term_horizontal:toggle()
--end

--function _TOGGLE_VERTICAL()
  --term_vertical:toggle()
--end

--function _TOGGLE_FLOAT()
  --term_float:toggle()
--end

---- =========================
---- ⌨️ Keymaps (VKSN + WHICH_KEY)
---- =========================
--VKSN("<leader>Tf", _TOGGLE_FLOAT, "Floating terminal")
--VKSN("<leader>Th", _TOGGLE_HORIZONTAL, "Horizontal terminal")
--VKSN("<leader>Tv", _TOGGLE_VERTICAL, "Vertical terminal")

---- Which-key integration
--WHICH_KEY({
  --["<leader>T"] = { name = "+Terminals" },
--})

