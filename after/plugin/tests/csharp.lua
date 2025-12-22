require("neotest").setup({
    adapters = {
    require("neotest-dotnet")({
        dap = { justMyCode = false },      -- optional, works with your DAP setup
        discovery_root = "solution",       -- auto-detect *.sln locations
    }),
      },
      quickfix = {
        enabled = true,
        open = false,
      },
      output = {
        open_on_run = false,
      },
      summary = {
        follow = true,
        expand_errors = true,
      },
})
