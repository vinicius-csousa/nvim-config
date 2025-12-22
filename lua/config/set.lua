vim.opt.nu = true
vim.opt.relativenumber = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.cursorline = true


vim.opt.smartindent = true

--vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false

local home = os.getenv("HOME") or os.getenv("USERPROFILE")
vim.opt.undodir = home .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
--
-- split windows
vim.opt.splitright = true -- split vertical window to the right
vim.opt.splitbelow = true -- split horizontal window to the bottom

vim.g.diagnostics_active = false

-- Set default colorscheme
vim.cmd("colorscheme tokyonight")

vim.g.clipboard = {
  name = "WslClipboard",
  copy = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe",
  },
  paste = {
    ["+"] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))',
    ["*"] = 'powershell.exe -NoLogo -NoProfile -c [Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))',
  },
  cache_enabled = 0,
}

