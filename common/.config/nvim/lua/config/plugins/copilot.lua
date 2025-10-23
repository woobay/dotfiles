return {
  {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require('copilot').setup({})
    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      model = 'claude-sonnet-4',
      window = {
	layout = 'vertical',
	width = 0.4,  -- 40% of screen width
      },
      contexts = {
	file = {
	  input = function(callback)
	    local telescope = require("telescope.builtin")
	    local actions = require("telescope.actions")
	    local action_state = require("telescope.actions.state")
	    telescope.find_files({
	      hidden = true,
	      no_ignore = true,
	      no_ignore_parent = true,
	      attach_mappings = function(prompt_bufnr)
		actions.select_default:replace(function()
		  actions.close(prompt_bufnr)
		  local selection = action_state.get_selected_entry()
		  callback(selection[1])
		end)
		return true
	      end,
	    })
	  end,
	},
	workspace = {
	  description = "The entire workspace/project",
	},
      },
    }
  },
}
