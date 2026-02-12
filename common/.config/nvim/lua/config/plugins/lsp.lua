return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'saghen/blink.cmp',
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
      
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      })
      
      -- New API for Neovim 0.11+
      vim.lsp.config('helm_ls', {
        capabilities = capabilities,
        cmd = { 'helm_ls', 'serve' },
        filetypes = { 'helm' },
        root_markers = { 'Chart.yaml' },
        settings = {
          ['helm-ls'] = {
            yamlls = {
              path = 'yaml-language-server',
            }
          }
        }
      })
      
      vim.lsp.config('yamlls', {
        capabilities = capabilities,
        cmd = { 'yaml-language-server', '--stdio' },
        filetypes = { 'yaml', 'yaml.docker-compose' },
      })
      
      vim.lsp.config('terraformls', {
        capabilities = capabilities,
        cmd = { 'terraform-ls', 'serve' },
        filetypes = { 'terraform', 'tf', 'terraform-vars' },
      })
      
      vim.api.nvim_create_autocmd({"BufWritePre"}, {
        pattern = {'*.tf', '*.tfvars'},
        callback = function()
          vim.lsp.buf.format()
        end
      })
    end
  }
}
