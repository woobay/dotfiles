return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    opts = {
      keymap = { preset = 'default' },

      appearance = {
	nerd_font_variant = 'mono'
      },
    },
    opts_extend = { "sources.default" }
  }
}
