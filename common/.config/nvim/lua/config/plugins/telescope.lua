return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function ()
      require('telescope').setup{
        defaults = {
        },
	pickers = {
          find_files = {
            theme = "ivy",
	    hidden = true,
            no_ignore = true,
            no_ignore_parent = true,
          },
	  live_grep = {
	    theme = "ivy"
	  }
        },
        extensions = {
          fzf = {}
        }
      }
      require('telescope').load_extension('fzf')
      vim.keymap.set('n', '<space>ff', require('telescope.builtin').find_files)
      vim.keymap.set('n', '<space>fg', require('telescope.builtin').live_grep)
      vim.keymap.set('n', '<space>fw', require('telescope.builtin').grep_string)
      vim.keymap.set('n', '<space>en', function()
	 require('telescope.builtin').find_files {
	   cwd = vim.env.home .. "/workspace/github.com/woobay/dotfiles/.config/nvim"
	 }
       end)
     end

   }
 }
