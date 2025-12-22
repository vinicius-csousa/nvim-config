local dap = require("dap")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

dap.adapters.coreclr = {
  type = "executable",
  command = vim.fn.expand("~/.local/share/nvim/mason/bin/netcoredbg"),
  args = { "--interpreter=vscode" },
}

local last_dll_config = nil

local function pick_dll_with_telescope(callback)
  local cwd = vim.fn.getcwd()
  local dlls = vim.fn.globpath(cwd, "**/bin/Debug/**/*.dll", true, true)

  -- Filter out test and framework DLLs
  local excluded_patterns = {
    "testhost", "xunit", "nunit", "Microsoft",
    "System", "netstandard", "Roslyn", "Tests",
    "AWSSDK", "Dapper", "Serilog", "Newtonsoft",
    "RabbitMQ"
  }

  local filtered = vim.tbl_filter(function(path)
    local name = vim.fn.fnamemodify(path, ":t")
    for _, pattern in ipairs(excluded_patterns) do
      if name:match(pattern) then return false end
    end
    return true
  end, dlls)

  if #filtered == 0 then
    vim.notify("No project DLLs found in the workspace", vim.log.levels.WARN)
    return
  end

  pickers.new({}, {
    prompt_title = "Select DLL to Debug",
    finder = finders.new_table({ results = filtered }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      local function on_select()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        local dll_path = selection[1]
        last_dll_config = {
          program = dll_path,
          cwd = vim.fn.fnamemodify(dll_path, ":h"),
        }

        callback(last_dll_config)
      end

      map("i", "<CR>", on_select)
      map("n", "<CR>", on_select)
      return true
    end,
  }):find()
end

local function create_launch_config(name, force_new)
  return {
    type = "coreclr",
    name = name,
    request = "launch",
    program = function()
      if force_new then
        last_dll_config = nil
      end

      if last_dll_config then
        return last_dll_config.program
      end

      return coroutine.create(function(coro)
        pick_dll_with_telescope(function(config)
          coroutine.resume(coro, config.program)
        end)
      end)
    end,
    cwd = function()
      return last_dll_config and last_dll_config.cwd or vim.fn.getcwd()
    end,
    stopAtEntry = false,
    env = {
      DOTNET_ENVIRONMENT = "Development",
      ASPNETCORE_ENVIRONMENT = "Development",
    },
    console = "integratedTerminal",
  }
end

dap.configurations.cs = {
  create_launch_config("Launch with netcoredbg", false),
  create_launch_config("Launch (pick new DLL)", true),
}

