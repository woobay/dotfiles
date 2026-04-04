return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-project.nvim',
    },
    config = function()
      local builtin = require('telescope.builtin')

      require('telescope').setup {
        defaults = {
          vimgrep_arguments = {
            'rg', '--color=never', '--no-heading',
            '--with-filename', '--line-number', '--column',
            '--smart-case',
            '--glob=!**/.git/**',
            '--glob=!**/node_modules/**',
          },
          path_display = { "truncate" },
          file_ignore_patterns = { "%.git/" },
        },
        pickers = {
          find_files = {
            theme = "ivy",
            hidden = true,
          },
          live_grep = { theme = "ivy" },
          lsp_references = { theme = "ivy" },
          lsp_definitions = { theme = "ivy" },
        },
        extensions = {
          fzf = {},
          project = {
            base_dirs = {
              { path = vim.env.HOME .. '/workspace/gitlab', max_depth = 3 },
              { path = vim.env.HOME .. '/workspace/github.com/woobay/', max_depth = 4 },
            },
            hidden_files = true,
            order_by = "recent",
            on_project_selected = function(prompt_bufnr)
              local project_actions = require('telescope._extensions.project.actions')
              project_actions.change_working_directory(prompt_bufnr, false)
            end
          }
        }
      }

      require('telescope').load_extension('fzf')
      require('telescope').load_extension('project')

      -- General
      vim.keymap.set('n', '<space>/', builtin.current_buffer_fuzzy_find)
      vim.keymap.set('n', '<space>ff', builtin.find_files)
      vim.keymap.set('n', '<space>fF', function()
        builtin.find_files { no_ignore = true, no_ignore_parent = true }
      end)
      vim.keymap.set('n', '<space>fg', builtin.live_grep)
      vim.keymap.set('n', '<space>fw', builtin.grep_string)
      vim.keymap.set('n', '<space>fb', builtin.buffers)
      vim.keymap.set('n', '<space>fo', builtin.oldfiles)
      vim.keymap.set('n', '<space>f.', builtin.resume)

      -- Project switcher
      vim.keymap.set('n', '<space>fp', function()
        require('telescope').extensions.project.project { display_type = 'full' }
      end)

      -- Scoped grep (prompts for directory)
      vim.keymap.set('n', '<space>fd', function()
        builtin.live_grep {
          search_dirs = { vim.fn.input("Dir: ", vim.fn.getcwd(), "dir") }
        }
      end)

      -- Find files relative to current file
      vim.keymap.set('n', '<space>fh', function()
        builtin.find_files { cwd = vim.fn.expand('%:p:h') }
      end)

      -- LSP
      vim.keymap.set('n', '<space>fs', builtin.lsp_document_symbols)
      vim.keymap.set('n', '<space>fS', builtin.lsp_workspace_symbols)
      vim.keymap.set('n', '<space>fr', builtin.lsp_references)

      -- Ansible
      vim.keymap.set('n', '<space>atj', function()
        builtin.find_files {
          prompt_title = "Jinja Templates",
          find_command = { "rg", "--files", "--glob", "*.j2" }
        }
      end)
      vim.keymap.set('n', '<space>av', function()
        builtin.live_grep {
          prompt_title = "Variable Definition",
          search_dirs = { "group_vars", "host_vars", "roles" },
        }
      end)
      vim.keymap.set('n', '<space>agv', function()
        builtin.live_grep { search_dirs = { "group_vars", "host_vars" } }
      end)
      vim.keymap.set('n', '<space>ap', function()
        builtin.find_files { search_dirs = { "playbooks" }, prompt_title = "Playbooks" }
      end)
      vim.keymap.set('n', '<space>ar', function()
        local role = vim.fn.input("Role: ")
        builtin.live_grep { search_dirs = { vim.fn.getcwd() .. "/roles/" .. role } }
      end)
      vim.keymap.set('n', '<space>aR', function()
        builtin.grep_string { glob_pattern = "*.yml" }
      end)

      -- Dotfiles
      vim.keymap.set('n', '<space>en', function()
        builtin.find_files {
          cwd = vim.env.HOME .. "/workspace/github.com/woobay/dotfiles/common/.config/nvim",
          hidden = true,
        }
      end)
      vim.keymap.set('n', '<space>dot', function()
        builtin.find_files {
          cwd = vim.env.HOME .. "/workspace/github.com/woobay/dotfiles",
          hidden = true,
        }
      end)
      vim.keymap.set('n', '<space>eb', function()
        vim.cmd('edit ' .. vim.env.HOME .. '/.bash_bell')
      end)
    end
  }
}
