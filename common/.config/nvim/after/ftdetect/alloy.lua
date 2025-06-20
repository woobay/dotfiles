vim.filetype.add({
  filename = {
    ["config.alloy"] = "alloy",
  },
  pattern = {
    [".*/config%.alloy"] = "alloy", -- fallback pattern match
  },
})

