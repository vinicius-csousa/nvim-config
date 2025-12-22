local neotest = require("neotest")


VKSN("<leader>Tt", function() neotest.run.run() end, "Run nearest test")
VKSN("<leader>Tf", function() neotest.run.run(vim.fn.expand("%")) end, "Run test file")
VKSN("<leader>Td", function() neotest.run.run({ strategy = "dap" }) end, "Debug nearest test")
VKSN("<leader>To", neotest.output.open, "Open test output")
VKSN("<leader>Tl", neotest.output_panel.open, "Open output panel")
VKSN("<leader>Ts", neotest.summary.toggle, "Toggle test summary")
VKSN("<leader>Tp", function() neotest.run.stop() end, "Stop nearest test")
VKSN("<leader>Ta", function() neotest.run.attach() end, "Attach to nearest test")

-- Which-key integration
WHICH_KEY({
  ["<leader>T"] = { name = "+Tests" },
})
